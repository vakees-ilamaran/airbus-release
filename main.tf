terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "2.16.0"
    }
  }
}

resource "docker_container" "deploy" {
  name  = "manager"
  image = "airbus-release:latest"
  ports {
      internal = 5000
      external = 5000
  }
}