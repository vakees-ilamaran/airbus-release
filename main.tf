resource "docker_container" "deploy" {
  name  = "manager"
  image = airbus-release.latest
  ports {
      internal = 5000
      external = 5000
  }
}