# Failed to create folder marker: mkdir /var/syncthing/nextcloud/.stfolder: permission denied
`sudo chmod -R 777 backup/`
add `* * * * * chmod -R 777 /mnt/backup/` to user crontab