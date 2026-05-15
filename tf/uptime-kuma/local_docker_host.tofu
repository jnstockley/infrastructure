resource "uptimekuma_docker_host" "local_socket" {
  provider      = uptimekuma.local
  name          = "Local Docker"
  docker_type   = "socket"
  docker_daemon = "/var/run/docker.sock"
}
