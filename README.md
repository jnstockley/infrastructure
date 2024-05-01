# Statuses
* Backups - [![Backups](https://github.com/jnstockley/infrastructure/actions/workflows/backups.yaml/badge.svg?branch=main)](https://github.com/jnstockley/infrastructure/actions/workflows/backups.yaml)
* Cameras - [![Cameras](https://github.com/jnstockley/infrastructure/actions/workflows/cameras.yaml/badge.svg)](https://github.com/jnstockley/infrastructure/actions/workflows/cameras.yaml)
* Speedtest - [![Speedtest](https://github.com/jnstockley/infrastructure/actions/workflows/speedtest.yaml/badge.svg)](https://github.com/jnstockley/infrastructure/actions/workflows/speedtest.yaml)
* Docker deploy - [![Docker](https://github.com/jnstockley/infrastructure/actions/workflows/docker.yml/badge.svg)](https://github.com/jnstockley/infrastructure/actions/workflows/docker.yml)
* Cloudflare - [![Cloudflare](https://github.com/jnstockley/infrastructure/actions/workflows/cloudflare.yaml/badge.svg)](https://github.com/jnstockley/infrastructure/actions/workflows/cloudflare.yaml)
* DNS Requests - [![DNS](https://github.com/jnstockley/infrastructure/actions/workflows/dns.yaml/badge.svg)](https://github.com/jnstockley/infrastructure/actions/workflows/dns.yaml)

# TODO
1. Auto updates for machines
    - create action to check if container can run on certain arch/os
3. Check if Hassio devices have issues (disconnected stuck on initializing)
4. see if way to check homekit if devices aren't responding 
5. get tests passing
6. add check for sensitive services
7. move containers to use local postgress db
8. get logs in a central location
9. setup sso
10. improve test error messages and loggin
11. convert speedtest to use cloudflare speedtest
12. notifications if no dns request from devices for so long
13. setup git mirror
14. check if using `docker image prune -a` works with nextcloud
