#!/bin/bash

# Public Networks
docker network create adguard --subnet=172.18.0.0/24
docker network create vaultwarden --subnet=172.18.1.0/24
docker network create nextcloud-aio --subnet=172.18.2.0/24
docker network create traefik --subnet=172.18.3.0/24
docker network create uptime-kuma --subnet=172.18.4.0/24
docker network create postgres-external --subnet=172.18.5.0/24
docker network create api --subnet=172.18.6.0/24
docker network create dockge --subnet=172.18.7.0/24
docker network create syncthing --subnet=172.18.8.0/24
docker network create gitea --subnet=172.18.9.0/24
docker network create authentik --subnet=172.18.10.0/24

# Private Networks
docker network create authentik-private --subnet=172.19.0.0/24
docker network create postgres-internal --subnet=172.19.1.0/24
docker network create redis --subnet=172.19.2.0/24
docker network create tailscale --subnet=172.19.3.0/24
docker network create cloudflared --subnet=172.19.4.0/24

