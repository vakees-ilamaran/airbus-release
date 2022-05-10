resource "docker_container" "deploy" {
  name  = "manager"
  image = airbus-release.latest
}