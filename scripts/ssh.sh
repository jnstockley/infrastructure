#!/usr/bin/env bash

# Exit on error
set -e

# Enable debug mode to see what's happening
set -x

# Function to show usage
function show_usage() {
    echo "Usage: $0 -u USERNAME -k SSH_KEY -p SSH_PASSPHRASE -h HOSTNAME -c \"COMMANDS\""
    echo
    echo "Arguments:"
    echo "  -u USERNAME        SSH username"
    echo "  -k SSH_KEY         Path to SSH private key or the key contents"
    echo "  -p SSH_PASSPHRASE  SSH key passphrase"
    echo "  -h HOSTNAME        Remote hostname or IP address"
    echo "  -c COMMANDS        Commands to execute (can be multiline)"
    echo
    exit 1
}

# Parse arguments
while getopts "u:k:p:h:c:" opt; do
    case $opt in
        u) SSH_USER="$OPTARG" ;;
        k) SSH_KEY="$OPTARG" ;;
        p) SSH_PASSPHRASE="$OPTARG" ;;
        h) SSH_HOST="$OPTARG" ;;
        c) SSH_COMMANDS="$OPTARG" ;;
        *) show_usage ;;
    esac
done

# Debug output - print what was received (masking sensitive data)
echo "Received arguments:"
echo "  User: $SSH_USER"
echo "  Host: $SSH_HOST"
echo "  Key length: ${#SSH_KEY} characters"
echo "  Passphrase length: ${#SSH_PASSPHRASE} characters"
echo "  Command length: ${#SSH_COMMANDS} characters"

# Check if all required arguments are provided
if [ -z "$SSH_USER" ] || [ -z "$SSH_KEY" ] || [ -z "$SSH_PASSPHRASE" ] || [ -z "$SSH_HOST" ] || [ -z "$SSH_COMMANDS" ]; then
    echo "Error: Missing required arguments."
    # Show which arguments are missing
    [ -z "$SSH_USER" ] && echo "Missing: SSH_USER"
    [ -z "$SSH_KEY" ] && echo "Missing: SSH_KEY"
    [ -z "$SSH_PASSPHRASE" ] && echo "Missing: SSH_PASSPHRASE"
    [ -z "$SSH_HOST" ] && echo "Missing: SSH_HOST"
    [ -z "$SSH_COMMANDS" ] && echo "Missing: SSH_COMMANDS"
    show_usage
fi

# Create temporary directory for SSH files
SSH_DIR=$(mktemp -d)
KEY_PATH="$SSH_DIR/id_rsa"

# Check if SSH_KEY is a file path or key content
if [ -f "$SSH_KEY" ]; then
    cp "$SSH_KEY" "$KEY_PATH"
else
    echo "$SSH_KEY" > "$KEY_PATH"
fi

# Set proper permissions
chmod 700 "$SSH_DIR"
chmod 600 "$KEY_PATH"

# Configure SSH to skip host verification
cat > "$SSH_DIR/config" << EOF
Host *
    StrictHostKeyChecking no
    UserKnownHostsFile=/dev/null
EOF
chmod 600 "$SSH_DIR/config"

# Check if expect is installed
if ! command -v expect &>/dev/null; then
    echo "Error: 'expect' is not installed. Please install it first."
    exit 1
fi

# Create expect script
EXPECT_SCRIPT="$SSH_DIR/ssh_script.exp"
cat > "$EXPECT_SCRIPT" << EOF
#!/usr/bin/expect -f
set timeout -1
spawn ssh -i $KEY_PATH -F $SSH_DIR/config $SSH_USER@$SSH_HOST "$SSH_COMMANDS"
expect {
    "Enter passphrase for key" {
        send "$SSH_PASSPHRASE\r"
        exp_continue
    }
    eof
}
EOF
chmod 700 "$EXPECT_SCRIPT"

# Execute expect script
"$EXPECT_SCRIPT"

# Clean up
rm -rf "$SSH_DIR"