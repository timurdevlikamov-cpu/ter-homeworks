terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0.0"
    }
  }
}


### Провайдер для контекста
provider "docker" {
  host = "ssh://<user>@<ip>"
}

### Генерация строки для имени контейнера
resource "random_id" "container_suffix" {
  byte_length = 4
}

### Генерим пароль для root-а
resource "random_password" "mysql_root_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}


### Генерим пароль для wordpress
resource "random_password" "mysql_user_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}


### Скачиваем образ MySQL
resource "docker_image" "mysql_image" {
  name         = "mysql:8"
  keep_locally = false
}


### Запуск контейнера с рандомными паролями и пробросом портов
resource "docker_container" "mysql_db" {
  # Используем интерполяцию в имени, как в примере с nginx
  name  = "mysql_${random_password.mysql_root_password.result}" 
  image = docker_image.mysql_image.image_id

  ports {
    internal = 3306
    external = 3306
  }

  env = [
    "MYSQL_ROOT_PASSWORD=${random_password.mysql_root_password.result}",
    "MYSQL_DATABASE=wordpress",
    "MYSQL_USER=wordpress",
    "MYSQL_PASSWORD=${random_password.mysql_user_password.result}",
    "MYSQL_ROOT_HOST=%"
  ]
}

# Получаем пароли в консоли
output "root_password" {
  value     = random_password.mysql_root_password.result
  sensitive = true
}

output "user_password" {
  value     = random_password.mysql_user_password.result
  sensitive = true
}
