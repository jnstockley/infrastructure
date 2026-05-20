resource "uptimekuma_docker_host" "public_socket" {
  provider      = uptimekuma.public
  name          = "Local Docker"
  docker_type   = "socket"
  docker_daemon = "/var/run/docker.sock"
}
