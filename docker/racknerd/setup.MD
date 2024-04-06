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
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

# [Setup Rootless Mode](https://docs.docker.com/engine/security/rootless/#install)
```bash
sudo systemctl disable --now docker.service docker.socket
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

