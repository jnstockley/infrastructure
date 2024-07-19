# Setup Using Debian 12
1. Follow racknerd's setup guide
2. Install btrfs `sudo apt install btrfs-progs`
3. Make directory `sudo mkdir -p /mnt/photos`
4. Add to fstab `sudo nano /etc/fstab` and add `/dev/sda1 /mnt/photos btrfs defaults 0 0`
5. Mount `sudo systemctl daemon-reload` and `sudo mount -a`