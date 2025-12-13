#!/usr/bin/env bash

# Exit on error
set -e

# Function to show usage
function show_usage() {
    echo "Usage: $0 -u USERNAME -k SSH_KEY -h HOSTNAME -c \"COMMANDS\""
    echo
    echo "Arguments:"
    echo "  -u USERNAME        SSH username"
    echo "  -k SSH_KEY         Path to SSH private key or the key contents"
    echo "  -h HOSTNAME        Remote hostname or IP address"
    echo "  -c COMMANDS        Commands to execute (can be multiline)"
    echo
    exit 1
}

# Initialize variables
SSH_USER=""
SSH_KEY=""
SSH_HOST=""
SSH_COMMANDS=""

# Parse arguments
while getopts ":u:k:p:h:c:" opt; do
    case $opt in
        u) SSH_USER="$OPTARG" ;;
        k) SSH_KEY="$OPTARG" ;;
        h) SSH_HOST="$OPTARG" ;;
        c) SSH_COMMANDS="$OPTARG" ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            show_usage
            ;;
        :)
            echo "Option -$OPTARG requires an argument." >&2
            show_usage
            ;;
    esac
done

# Check if all required arguments are provided
if [ -z "$SSH_USER" ] || [ -z "$SSH_KEY" ] || [ -z "$SSH_HOST" ] || [ -z "$SSH_COMMANDS" ]; then
    echo "Error: Missing required arguments."
    [ -z "$SSH_USER" ] && echo "Missing: SSH_USER"
    [ -z "$SSH_KEY" ] && echo "Missing: SSH_KEY"
    [ -z "$SSH_HOST" ] && echo "Missing: SSH_HOST"
    [ -z "$SSH_COMMANDS" ] && echo "Missing: SSH_COMMANDS"
    show_usage
fi

# Create temporary directory for SSH files
SSH_DIR=$(mktemp -d)
KEY_PATH="$SSH_DIR/id_rsa"

# Save the key content to the key file
echo "$SSH_KEY" >"$KEY_PATH"

# Set proper permissions
chmod 700 "$SSH_DIR"
chmod 600 "$KEY_PATH"

# Configure SSH to skip host verification
cat >"$SSH_DIR/config" <<EOF
Host *
    StrictHostKeyChecking no
    UserKnownHostsFile=/dev/null
EOF
chmod 600 "$SSH_DIR/config"

# Create a script with the commands to run
COMMAND_FILE="$SSH_DIR/commands.sh"
echo "$SSH_COMMANDS" >"$COMMAND_FILE"
chmod +x "$COMMAND_FILE"

# Create expect script that sends the password correctly
cat >"$SSH_DIR/ssh_expect.exp" <<'EOF'
#!/usr/bin/expect -f

if {[llength $argv] < 5} {
    puts "Usage: $argv0 KEY_PATH CONFIG_PATH USER HOST PASSPHRASE COMMANDS_FILE"
    exit 1
}

set KEY_PATH [lindex $argv 0]
set CONFIG_PATH [lindex $argv 1]
set USER [lindex $argv 2]
set HOST [lindex $argv 3]
set PASSPHRASE [lindex $argv 4]
set COMMANDS_FILE [lindex $argv 5]

set timeout 300
set COMMANDS [exec cat $COMMANDS_FILE]

spawn ssh -i $KEY_PATH -F $CONFIG_PATH $USER@$HOST "$COMMANDS"

expect {
    "Enter passphrase for key" {
        send "$PASSPHRASE\r"
        exp_continue
    }
    timeout {
        puts "Connection timed out"
        exit 1
    }
    eof
}

catch wait result
exit [lindex $result 3]
EOF
chmod 700 "$SSH_DIR/ssh_expect.exp"

# Execute the expect script
expect "$SSH_DIR/ssh_expect.exp" "$KEY_PATH" "$SSH_DIR/config" "$SSH_USER" "$SSH_HOST" "$COMMAND_FILE"

# Clean up
rm -rf "$SSH_DIR"
