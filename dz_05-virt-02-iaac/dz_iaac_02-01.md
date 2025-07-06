#  Задача 1
## Установите на личный Linux-компьютер или учебную локальную ВМ с Linux следующие сервисы(желательно ОС ubuntu 20.04):

### * VirtualBox,
  > sudo apt install virtualbox
  
### * Vagrant, рекомендуем версию 2.3.4
Последняя версия в репозитории ubuntu 2.2.6. Скачал и установил deb пакет 2.3.4 версии с оффициального репозитория hashicorp.
  > sudo dpkg -i vagrant_2.3.4-1_amd64.deb
  
### * Packer версии 1.9.х + плагин от Яндекс Облако по инструкции
Последняя версия в репозитории ubuntu 1.3.4. Скачал и установил c репозитория yandex версию 1.9.5.
  > mkdir packer
> 
  > wget https://hashicorp-releases.yandexcloud.net/packer/1.9.5/packer_1.9.5_linux_amd64.zip -P ~/packer
> 
  > unzip ~/packer/packer_1.9.5_linux_amd64.zip -d ~/packer
> sudo cp packer /usr/bin/

### * уandex cloud cli Так же инициализируйте профиль с помощью yc init .
  > curl -sSL https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash
  
  После завершения установки перезапустите командную оболочку
  > exec bash

  Инициализируем профиль
  > yc init

### Версии установленых компонентов.
```
   aleksandrov_sp@aleksandrov-sp-dev:~/vagrant$ VBoxManage --version
   6.1.50_Ubuntur161033

   aleksandrov_sp@aleksandrov-sp-dev:~/vagrant$ vagrant --version
   Vagrant 2.3.4

   aleksandrov_sp@aleksandrov-sp-dev:~/packer$ packer --version
   1.9.5
```

# Задача 2
1. Убедитесь, что у вас есть ssh ключ в ОС или создайте его с помощью команды ssh-keygen -t ed25519
2. Создайте виртуальную машину Virtualbox с помощью Vagrant и Vagrantfile в директории src.
3. Зайдите внутрь ВМ и убедитесь, что Docker установлен с помощью команды:
docker version && docker compose version

1. SSH ключ был создан ранее.
2. Виртуальная машина создана. В виду ограниченого доступа к репозиториям hashicorp с территории РФ, скачал образ системы с зеркала и добавил его в vagrant
    > vagrant box add db50d2a7-2dd2-4beb-b2ff-3f1c04e5d11a --name=ubuntu-20.04 --provider=virtualbox --force
    > aleksandrov_sp@aleksandrov-sp-dev:~$ vagrant box list
      ubuntu-20.04 (virtualbox, 0)

   Далее отредактировал файл vagrantfile т.к. при добалении образа системы задал другое имя. И запустил создание виртуальной машины.
    > vagrant up

3. Проверил версию Docker и docker compose
   ```
   vagrant@server1:~$ sudo docker version && docker compose version
   Client: Docker Engine - Community
     Version:           28.1.1
     API version:       1.49
     Go version:        go1.23.8
     Git commit:        4eba377
     Built:             Fri Apr 18 09:52:18 2025
     OS/Arch:           linux/amd64
     Context:           default <

    Server: Docker Engine - Community
     Engine:
      Version:          28.1.1
      API version:      1.49 (minimum version 1.24)
      Go version:       go1.23.8
      Git commit:       01f442b
      Built:            Fri Apr 18 09:52:18 2025
      OS/Arch:          linux/amd64
      Experimental:     false
     containerd:
      Version:          1.7.27
      GitCommit:        05044ec0a9a75232cad458027ca83437aae3f4da
     runc:
      Version:          1.2.5
      GitCommit:        v1.2.5-0-g59923ef
     docker-init:
      Version:          0.19.0
      GitCommit:        de40ad0
    Docker Compose version v2.35.1
```

# Задача 3
1.Отредактируйте файл mydebian.json.pkr.hcl или mydebian.jsonl в директории src (packer умеет и в json, и в hcl форматы):
  * добавьте в скрипт установку docker. Возьмите скрипт установки для debian из документации к docker,
  * дополнительно установите в данном образе htop и tmux.(не забудьте про ключ автоматического подтверждения установки для apt)
2. Найдите свой образ в web консоли yandex_cloud
3. Необязательное задание(*): найдите в документации yandex cloud как найти свой образ с помощью утилиты командной строки "yc cli".
4. Создайте новую ВМ (минимальные параметры) в облаке, используя данный образ.
5. Подключитесь по ssh и убедитесь в наличии установленного docker.
6. Удалите ВМ и образ.
7. ВНИМАНИЕ! Никогда не выкладываете oauth token от облака в git-репозиторий! Утечка секретного токена может привести к финансовым потерям. После выполнения задания обязательно удалите секретные данные из файла mydebian.json и mydebian.json.pkr.hcl. (замените содержимое токена на "ххххх")
8. В качестве ответа на задание загрузите результирующий файл в ваш ЛК.

1. Файл mydebian.json отредактирован
```
    "builders": [
        {
            "type": "yandex",
            "token": "y0__xC55vOuARjB3RMg_4Oo3RO7Qsb04Boo6M6YmyCW6Kg-vsqLRw",
            "folder_id": "b1g18m3fmokhkjuqb2r2",
            "zone": "ru-central1-a",
            "image_name": "debian-11-docker",
            "image_description": "my custom debian with docker",
            "source_image_family": "debian-11",
            "subnet_id": "e9b01c6stm7p7bd8sefh",
            "use_ipv4_nat": true,
            "disk_type": "network-hdd",
            "ssh_username": "debian"
        }
    ],
    "provisioners": [
        {
            "type": "shell",
            "inline": [
              "sudo apt-get update",
              "sudo apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release",
              "curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg",
              "echo \"deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian bullseye stable\" | sudo tee /etc/apt/sources.list.d/docker.list >
              "sudo apt-get update",
              "sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin"
            ]
        }
    ]
```

aleksandrov_sp@aleksandrov-sp-dev:~/packer$ yc compute image list
+----------------------+------------------+--------+----------------------+--------+
|          ID          |       NAME       | FAMILY |     PRODUCT IDS      | STATUS |
+----------------------+------------------+--------+----------------------+--------+
| fd8716m019qvlnms2d2u | debian-11-docker |        | f2eh2keamkps7ekhfjge | READY  |
+----------------------+------------------+--------+----------------------+--------+





