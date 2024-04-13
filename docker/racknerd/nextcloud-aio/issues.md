# Reverse proxy not setup correctly
- Update traefik nextcloud config to point to nextcloud-aio-domiancheck

# Rate limit issue
- `docker exec -it nextcloud-aio-nextcloud /bin/bash`
- `ping traefik`
- `sudo -u www-data php -d memory_limit=512M /var/www/html/occ security:bruteforce:reset 172.20.0.3`
- enable `Brute-force settings` app
- add `172.20.0.0/8`
172.20.0.2