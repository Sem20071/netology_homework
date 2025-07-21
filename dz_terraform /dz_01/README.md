## Чек-лист готовности к домашнему заданию
1. Скачайте и установите Terraform версии >=1.8.4 . Приложите скриншот вывода команды terraform --version.
2. Скачайте на свой ПК этот git-репозиторий. Исходный код для выполнения задания расположен в директории 01/src.
3. Убедитесь, что в вашей ОС установлен docker.

## Ответ:
https://github.com/Sem20071/netology_homework/blob/main/dz_terraform%20/dz_01/images/check_00.png


## Задание 1
1. Перейдите в каталог src. Скачайте все необходимые зависимости, использованные в проекте.
2. Изучите файл .gitignore. В каком terraform-файле, согласно этому .gitignore, допустимо сохранить личную, секретную информацию?(логины,пароли,ключи,токены итд)
3. Выполните код проекта. Найдите в state-файле секретное содержимое созданного ресурса random_password, пришлите в качестве ответа конкретный ключ и его значение.
4. Раскомментируйте блок кода, примерно расположенный на строчках 29–42 файла main.tf. Выполните команду terraform validate. Объясните, в чём заключаются намеренно допущенные ошибки. Исправьте их.
5. Выполните код. В качестве ответа приложите: исправленный фрагмент кода и вывод команды docker ps.
6. Замените имя docker-контейнера в блоке кода на hello_world. Не перепутайте имя контейнера и имя образа. Мы всё ещё продолжаем использовать name = "nginx:latest". Выполните команду terraform apply -auto-approve. Объясните     своими словами, в чём может быть опасность применения ключа -auto-approve. Догадайтесь или нагуглите зачем может пригодиться данный ключ? В качестве ответа дополнительно приложите вывод команды docker ps.
7. Уничтожьте созданные ресурсы с помощью terraform. Убедитесь, что все ресурсы удалены. Приложите содержимое файла terraform.tfstate.
8. Объясните, почему при этом не был удалён docker-образ nginx:latest. Ответ ОБЯЗАТЕЛЬНО НАЙДИТЕ В ПРЕДОСТАВЛЕННОМ КОДЕ, а затем ОБЯЗАТЕЛЬНО ПОДКРЕПИТЕ строчкой из документации terraform провайдера docker. (ищите в              классификаторе resource docker_image )

## Ответ:
1. https://github.com/Sem20071/netology_homework/blob/main/dz_terraform%20/dz_01/images/terraform-01-1.png
2. В файле personal.auto.tfvars допустимо сохранить личную, секретную информацию.
3. https://github.com/Sem20071/netology_homework/blob/main/dz_terraform%20/dz_01/images/terraform-01-3.png
  > "result": "lyqf6fC8tvf1QTEK",

4.  Ошибка №1 в блоке resource "docker_image" > resource "docker_image" "nginx"
    Ошибка №2 в блоке resource "docker_container" "1nginx" > resource "docker_container" "nginx"
    Ошибка №3 в строке name  = "example_${random_password.random_string_FAKE.resulT}" > name  = "example_${random_password.random_string.result}"
    После указанных исправлений выполняем terraform validate
  > Success! The configuration is valid.
5. Исправленный фрагмент кода:
```
resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = true
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = "example_${random_password.random_string.result}"

  ports {
    internal = 80
    external = 9090
  }
}
```
Вывод команды docker ps:
https://github.com/Sem20071/netology_homework/blob/main/dz_terraform%20/dz_01/images/terraform-01-5.png

6. 
