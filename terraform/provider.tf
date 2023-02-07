terraform {
  required_providers {
    vkcs = {
      source = "vk-cs/vkcs"
    }
  }
}

provider "vkcs"  {
    username = var.username
    password = var.password
    project_id = var.project_id
    region = var.region
}