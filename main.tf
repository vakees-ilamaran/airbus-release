terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "2.16.0"
    }
  }
}

variable "tag" {
    type        = string
    description = "This is the tag used for docker image"
}

resource "docker_container" "deploy" {
  name  = "manager"
  image = "airbus-release:${var.tag}"
  ports {
      internal = 5000
      external = 5000
  }
}