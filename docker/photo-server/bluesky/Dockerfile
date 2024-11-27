FROM debian:12.8

RUN apt-get update && apt-get install -y curl lsb-release

RUN curl https://raw.githubusercontent.com/bluesky-social/pds/main/installer.sh >installer.sh

RUN chmod +x installer.sh

RUN bash installer.sh