# Setup Using Debian 12
1. Follow racknerd's setup guide
2. Make directory `sudo mkdir -p /mnt/photos`
3. Add to fstab `sudo nano /etc/fstab` and add `/dev/sda1 /mnt/photos btrfs defaults 0 0`
4. Mount `sudo systemctl daemon-reload` and `sudo mount -a`

## Mount drive using UUID
1. Get UUID `lsblk -f`
2. Add to fstab `sudo nano /etc/fstab` and add `UUID=xxxx-xxxx-xxxx-xxxx <MOUNT_POINT> <FILESYSTEM> defaults 0 0`