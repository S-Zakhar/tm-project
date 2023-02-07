# Terraform манифесты для разворачивания инфраструктуры  

## Инфраструктура:
6 виртуальных машин, 1 vcpu, 2 GB, 20 GB, Ubuntu 20.04  

## Установка Terraform  
Полностью согласно офф. мануалу:
https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli

## Настройка провайдера Terraform для MCS  
Создаём файл:
```
nano $HOME/.terraformrc
```
с кодом:
```
provider_installation {
  network_mirror {
    url = "https://hub.mcs.mail.ru/repository/terraform-providers/"
    include = ["vk-cs/*"]
  }
  direct {
    exclude = ["vk-cs/*"]
  }
}
```
Подробнее в мануале:  
https://mcs.mail.ru/docs/additionals/terraform/terraform-provider-config#  

## Вносим все значения в vars.tf  
На основе vars.tf.example вносим все свои реквизиты. 
Основные из них берём здесь:  
https://mcs.mail.ru/app/project/keys

## Запускаем
Инициализируем Terraform и скачиваем provider:  
```
terraform init
```
Запускаем манифесты:
```
terraform apply
```
Если всё ок, консоль выведет список всего, что планирует отправить в Облако для создания (не факт, что всё создастся, если есть ошибки в манифестах).  
На предложение продолжить напечатать **yes**

Ждём. Если всё ок, в output выведутся ip созданных машин.
