resource "docker_container" "deploy" {
  name  = "manager"
  image = manager.latest
}