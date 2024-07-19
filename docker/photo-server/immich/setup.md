# Install Nvidia driver
```bash
sudo apt install software-properties-common -y
sudo add-apt-repository contrib non-free-firmware
sudo apt update
sudo apt install linux-headers-amd64
sudo apt install nvidia-detect
sudo apt install nvidia-driver linux-image-amd64
```