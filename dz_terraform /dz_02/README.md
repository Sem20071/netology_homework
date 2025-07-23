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
4. Ошибками назвать не могу, скорее корректировка кода под свои данные
   - Ошибка в блоке resource "yandex_compute_instance" "platform" , platform_id = "standart-v4"  исправил на platform_id = "standard-v1"
   - Данная ошибка "he specified number of cores is not available on platform "standard-v1"; allowed core number: 2, 4" намекает нам что необходимо установить колличество ядер создоваемых ВМ в значение 2 или 4, исправил           cores = 1 на cores = 2 в блоке resource "yandex_compute_instance" "platform".
   - metadata = { serial-port-enable = 1 исправил на metadata = { serial-port-enable = true, у параметра serial-port-enable должен быт установлен тип boolean
6. preemptible = true этот параметр в значение true делает машину прерываемой. Параметр core_fraction=5
   
![cСкриншот ЛК YC с созданной ВМ](https://github.com/Sem20071/netology_homework/blob/main/dz_terraform%20/dz_02/images/terraform-02-1.png)
![Скриншот консоли](https://github.com/Sem20071/netology_homework/blob/main/dz_terraform%20/dz_02/images/terraform-02-5.png)
