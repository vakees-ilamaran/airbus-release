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

variable "port" {
    type        = number
    description = "port for the service"
}

resource "docker_container" "deploy" {
  name  = "manager-${var.tag}"
  image = "airbus-release:${var.tag}"
  ports {
      internal = var.port
      external = var.port
  }
}