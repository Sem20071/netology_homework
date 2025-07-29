## Задание 1
1. Возьмите из демонстрации к лекции готовый код для создания с помощью двух вызовов remote-модуля -> двух ВМ, относящихся к разным проектам(marketing и analytics) используйте labels для обозначения принадлежности. В файле cloud-init.yml необходимо использовать переменную для ssh-ключа вместо хардкода. Передайте ssh-ключ в функцию template_file в блоке vars ={} . Воспользуйтесь примером. Обратите внимание, что ssh-authorized-keys принимает в себя список, а не строку.
2. Добавьте в файл cloud-init.yml установку nginx.
3. Предоставьте скриншот подключения к консоли и вывод команды sudo nginx -t, скриншот консоли ВМ yandex cloud с их метками. Откройте terraform console и предоставьте скриншот содержимого модуля. Пример: > module.marketing_vm

## Ответ:
### Скриншот консоли и вывод команды sudo nginx -t.
![Скриншот консоли и вывод команды sudo nginx -t](https://github.com/Sem20071/netology_homework/blob/main/dz_terraform%20/dz_04/images/terraform-04-01-1.png).
### Скриншот 1 консоли ВМ yandex cloud с их метками.
![скриншот консоли ВМ yandex cloud с их метками 1](https://github.com/Sem20071/netology_homework/blob/main/dz_terraform%20/dz_04/images/terraform-04-01-2.png).
### Скриншот 2 консоли ВМ yandex cloud с их метками.
![скриншот консоли ВМ yandex cloud с их метками 2](https://github.com/Sem20071/netology_homework/blob/main/dz_terraform%20/dz_04/images/terraform-04-01-3.png).
### Скриншот terraform console содержимого модуля.
![скриншот terraform console](https://github.com/Sem20071/netology_homework/blob/main/dz_terraform%20/dz_04/images/terraform-04-01-4.png).

## Задание 2
1. Напишите локальный модуль vpc, который будет создавать 2 ресурса: одну сеть и одну подсеть в зоне, объявленной при вызове модуля, например: ru-central1-a.
2. Вы должны передать в модуль переменные с названием сети, zone и v4_cidr_blocks.
3. Модуль должен возвращать в root module с помощью output информацию о yandex_vpc_subnet. Пришлите скриншот информации из terraform console о своем модуле. Пример: > module.vpc_dev
4. Замените ресурсы yandex_vpc_network и yandex_vpc_subnet созданным модулем. Не забудьте передать необходимые параметры сети из модуля vpc в модуль с виртуальной машиной.
5. Сгенерируйте документацию к модулю с помощью terraform-docs.

## Ответ:
### 1. https://github.com/Sem20071/netology_homework/blob/main/dz_terraform%20/dz_04/vpc_prod_module/main.tf
### 3. Cкриншот информации из terraform console о написанном модуле.
![Скриншот консоли](https://github.com/Sem20071/netology_homework/blob/main/dz_terraform%20/dz_04/images/terraform-04-02-3.png).
### 5. Скриншот документации к написанному модулю.
![Скриншот консоли](https://github.com/Sem20071/netology_homework/blob/main/dz_terraform%20/dz_04/images/terraform-04-02-4.png).

## Задание 3
1. Выведите список ресурсов в стейте.
2. Полностью удалите из стейта модуль vpc.
3. Полностью удалите из стейта модуль vm.
4. Импортируйте всё обратно. Проверьте terraform plan. Значимых(!!) изменений быть не должно. Приложите список выполненных команд и скриншоты процессы.

## Ответ:
1. 



