# https://github.com/Sem20071/netology_homework/tree/main/dz_terraform%20/dz_02

## Задание 1
В качестве ответа всегда полностью прикладывайте ваш terraform-код в git. Убедитесь что ваша версия Terraform ~>1.8.4

1. Изучите проект. В файле variables.tf объявлены переменные для Yandex provider.
2. Создайте сервисный аккаунт и ключ. service_account_key_file.
3. Сгенерируйте новый или используйте свой текущий ssh-ключ. Запишите его открытую(public) часть в переменную vms_ssh_public_root_key.
4. Инициализируйте проект, выполните код. Исправьте намеренно допущенные синтаксические ошибки. Ищите внимательно, посимвольно. Ответьте, в чём заключается их суть.
5. Подключитесь к консоли ВМ через ssh и выполните команду  curl ifconfig.me. Примечание: К OS ubuntu "out of a box, те из коробки" необходимо подключаться под пользователем ubuntu: "ssh ubuntu@vm_ip_address". Предварительно убедитесь, что ваш ключ добавлен в ssh-агент: eval $(ssh-agent) && ssh-add Вы познакомитесь с тем как при создании ВМ создать своего пользователя в блоке metadata в следующей лекции.;
6. Ответьте, как в процессе обучения могут пригодиться параметры preemptible = true и core_fraction=5 в параметрах ВМ.
В качестве решения приложите:

- скриншот ЛК Yandex Cloud с созданной ВМ, где видно внешний ip-адрес;
- скриншот консоли, curl должен отобразить тот же внешний ip-адрес;
- ответы на вопросы.

## Ответ:
4. Были внесены сл. исправления
   - Ошибка в блоке resource "yandex_compute_instance" "platform" , platform_id = "standart-v4"  исправил на platform_id = "standard-v1"
   - Данная ошибка "he specified number of cores is not available on platform "standard-v1"; allowed core number: 2, 4" намекает нам что необходимо установить колличество ядер создоваемых ВМ в значение 2 или 4, исправил           cores = 1 на cores = 2 в блоке resource "yandex_compute_instance" "platform".
6. preemptible = true этот параметр в значение true делает машину прерываемой. Параметр core_fraction=5 определяет уровень производительности vCPU, в нашем случае это 5%. Данные параметры при правильной настройке позволяют существенно сэкономить облачные ресурсы и сократить расходы на использование этих ресурсов.
   
![cСкриншот ЛК YC с созданной ВМ](https://github.com/Sem20071/netology_homework/blob/main/dz_terraform%20/dz_02/images/terraform-02-1.png)
![Скриншот консоли](https://github.com/Sem20071/netology_homework/blob/main/dz_terraform%20/dz_02/images/terraform-02-5.png)

## Задание 2
1. Замените все хардкод-значения для ресурсов yandex_compute_image и yandex_compute_instance на отдельные переменные. К названиям переменных ВМ добавьте в начало префикс vm_web_ . Пример: vm_web_name.
2. Объявите нужные переменные в файле variables.tf, обязательно указывайте тип переменной. Заполните их default прежними значениями из main.tf.
3. Проверьте terraform plan. Изменений быть не должно.

## Ответ:
### https://github.com/Sem20071/netology_homework/blob/main/dz_terraform%20/dz_02/main.tf

## Задание 3
1. Создайте в корне проекта файл 'vms_platform.tf' . Перенесите в него все переменные первой ВМ.
2. Скопируйте блок ресурса и создайте с его помощью вторую ВМ в файле main.tf: "netology-develop-platform-db" , cores  = 2, memory = 2, core_fraction = 20. Объявите её переменные с префиксом vm_db_ в том же файле ('vms_platform.tf'). ВМ должна работать в зоне "ru-central1-b"
3. Примените изменения.

## Ответ:
### https://github.com/Sem20071/netology_homework/blob/main/dz_terraform%20/dz_02/vms_platform.tf
### https://github.com/Sem20071/netology_homework/blob/main/dz_terraform%20/dz_02/main.tf

## Задание 4
1. Объявите в файле outputs.tf один output , содержащий: instance_name, external_ip, fqdn для каждой из ВМ в удобном лично для вас формате.(без хардкода!!!)
2. Примените изменения.
В качестве решения приложите вывод значений ip-адресов команды terraform output

## Ответ:
![Скриншот вывода команды terraform output](https://github.com/Sem20071/netology_homework/blob/main/dz_terraform%20/dz_02/images/terraform-02-04-0.png).

## Задание 5
1. В файле locals.tf опишите в одном local-блоке имя каждой ВМ, используйте интерполяцию ${..} с НЕСКОЛЬКИМИ переменными по примеру из лекции.
2. Замените переменные внутри ресурса ВМ на созданные вами local-переменные.
3. Примените изменения.

## Ответ:
### https://github.com/Sem20071/netology_homework/blob/main/dz_terraform%20/dz_02/locals.tf

## Задание 6
1. Вместо использования трёх переменных ".._cores",".._memory",".._core_fraction" в блоке resources {...}, объедините их в единую map-переменную vms_resources и внутри неё конфиги обеих ВМ в виде вложенного map(object).
2. Создайте и используйте отдельную map(object) переменную для блока metadata, она должна быть общая для всех ваших ВМ.
3. Найдите и закоментируйте все, более не используемые переменные проекта.
4. Проверьте terraform plan. Изменений быть не должно.

## Ответ:
https://github.com/Sem20071/netology_homework/blob/main/dz_terraform%20/dz_02/vms_platform.tf


