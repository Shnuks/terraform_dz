terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider "docker" {
  host = "ssh://terroform_user@${var.vm_ip}"
}

resource "random_password" "mysql_root_password" {
  length  = 16
  special = false
}

resource "random_password" "mysql_user_password" {
  length  = 16
  special = false 
}

resource "docker_container" "mysql" {
  name  = "mysql-db-${random_password.mysql_root_password.result}"
  image = "mysql:8"

  ports {
    internal = 3306
    external = 3306
    ip       = "127.0.0.1"
  }

  env = [
    "MYSQL_ROOT_PASSWORD=${random_password.mysql_root_password.result}",
    "MYSQL_DATABASE=wordpress",
    "MYSQL_USER=wordpress",
    "MYSQL_PASSWORD=${random_password.mysql_user_password.result}",
    "MYSQL_ROOT_HOST=%"
  ]

  restart = "always"
}
