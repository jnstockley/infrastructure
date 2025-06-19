# Setup Using Debian 12
1. Update packages `apt update` and `apt upgrade -y`
2. Create new user `adduser jackstockley`
3. Install and setup doas `apt install doas` and `echo "permit persist jackstockley as root" >> /etc/doas.conf`
4. Install nala `apt install nala`
5. Reconnect as jackstockley
6. Add alias 
    ```bash
    export PATH=/usr/bin:/usr/sbin:$PATH
    
    # Nala
    apt() {
      command nala "$@"
    }
    sudo() {
      if [ "$1" = "apt" ]; then
        shift
        command doas nala "$@"
      else
        command doas "$@"
      fi
    }
    
    alias reboot='sudo systemctl reboot'
    ```
7. Reboot
8. Copy ssh keys `ssh-copy-id -i ~/.ssh/id_ed25519.pub jackstockley@172.245.131.22`
9. Disable root and password ssh `sudo nano /etc/ssh/sshd_config` and `PermitRootLogin no` and 
   `PubkeyAuthentication yes` and `PasswordAuthentication no` and `sudo systemctl restart ssh` and `sudo systemctl restart sshd`
10. Install ufw and enable `sudo apt install ufw` and `sudo ufw allow 22` and `sudo ufw allow 80` and `sudo ufw allow 443` 
    and `sudo ufw enable`
11. Install gh cli 
    ```bash
    sudo mkdir -p -m 755 /etc/apt/keyrings && wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
    && sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && sudo apt update \
    && sudo apt install gh -y
    ```
12. Auth with GH CLI using ssh
13. Install docker and setup rootless mode
14. Add `net.ipv4.ip_unprivileged_port_start=53` to `/etc/sysctl.conf` and `sudo sysctl --system`
15. Clone GitHub repo and setup containers


# [Install Docker](https://docs.docker.com/engine/install/debian/)
```bash
for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get remove $pkg; done
```
```bash
sudo apt update
```
```bash
sudo apt install ca-certificates curl
```
```bash
sudo install -m 0755 -d /etc/apt/keyrings
```
```bash
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
```
```bash
sudo chmod a+r /etc/apt/keyrings/docker.asc
```
```bash
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```
```bash
sudo apt update
```
```bash
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

# Add user to docker group
```bash
sudo groupadd docker
````
```bash
sudo usermod -aG docker $USER
```
```bash
newgrp docker
```
# [Setup Rootless Mode](https://docs.docker.com/engine/security/rootless/#install)
```bash
sudo systemctl disable --now docker.service docker.socket
```
```bash
sudo sh -eux <<EOF
apt-get install -y uidmap
EOF
```
```bash
/usr/bin/dockerd-rootless-setuptool.sh install
```
```bash
export PATH=/usr/bin:$PATH
echo "export PATH=/usr/bin:$PATH" >> ~/.bashrc
```
```bash
export DOCKER_HOST=unix:///run/user/1000/docker.sock
echo "export DOCKER_HOST=unix:///run/user/1000/docker.sock" >> ~/.bashrc
```
```bash
systemctl --user start docker
```
```bash
systemctl --user enable docker
```
```bash
sudo loginctl enable-linger $(whoami)
```

# [Install Sudo (doas)](https://www.makeuseof.com/how-to-install-and-use-doas/)

