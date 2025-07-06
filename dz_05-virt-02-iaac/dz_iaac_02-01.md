#  Задача 1
## Установите на личный Linux-компьютер или учебную локальную ВМ с Linux следующие сервисы(желательно ОС ubuntu 20.04):

### * VirtualBox,
  > sudo apt install virtualbox
  
### * Vagrant, рекомендуем версию 2.3.4
Последняя версия в репозитории ubuntu 2.2.6. Скачал и установил deb пакет 2.3.4 версии с оффициального репозитория hashicorp.
  > sudo dpkg -i vagrant_2.3.4-1_amd64.deb
  
### * Packer версии 1.9.х + плагин от Яндекс Облако по инструкции
Скачал и установил c репозитория Packer 1.9.5 + плагин с yandex облака.
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
## 1. Убедитесь, что у вас есть ssh ключ в ОС или создайте его с помощью команды ssh-keygen -t ed25519
SSH ключ был создан ранее.

## 2. Создайте виртуальную машину Virtualbox с помощью Vagrant и Vagrantfile в директории src.
 Виртуальная машина создана. В виду ограниченого доступа к репозиториям hashicorp с территории РФ, скачал образ системы с зеркала и добавил его в vagrant
 
> aleksandrov_sp@aleksandrov-sp-dev:~$ vagrant box add db50d2a7-2dd2-4beb-b2ff-3f1c04e5d11a --name=ubuntu-20.04 --provider=virtualbox --force
> 
> aleksandrov_sp@aleksandrov-sp-dev:~$ vagrant box list
  ubuntu-20.04 (virtualbox, 0)

   Далее отредактировал файл vagrantfile. И запустил создание виртуальной машины.
    > vagrant up

## 3. Зайдите внутрь ВМ и убедитесь, что Docker установлен с помощью команды:
docker version && docker compose version
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
## 1.Отредактируйте файл mydebian.json.pkr.hcl или mydebian.jsonl в директории src (packer умеет и в json, и в hcl форматы):
##   * добавьте в скрипт установку docker. Возьмите скрипт установки для debian из документации к docker,
##   * дополнительно установите в данном образе htop и tmux.(не забудьте про ключ автоматического подтверждения установки для apt)
Файл mydebian.json отредактирован
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
              "sudo apt-get install -y ca-certificates curl",
              "sudo install -m 0755 -d /etc/apt/keyrings",
              "sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc",
              "sudo chmod a+r /etc/apt/keyrings/docker.asc",
              "echo \"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian bullseye stable\" | sudo tee /etc/apt/sources.list.d/docker.>
              "sudo apt-get update",
              "sudo apt-get install htop -y",
              "sudo apt-get install tmux -y",
              "sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin"
            ]
        }
    ]
```

## 2. Найдите свой образ в web консоли yandex_cloud
   https://github.com/Sem20071/netology_homework/blob/main/dz_05-virt-02-iaac/images/dz_05-virt-02-iaac-01.png
   
## 3. Необязательное задание(*): найдите в документации yandex cloud как найти свой образ с помощью утилиты командной строки "yc cli".
```
> aleksandrov_sp@aleksandrov-sp-dev:~/packer$ yc compute image list
+----------------------+------------------+--------+----------------------+--------+
|          ID          |       NAME       | FAMILY |     PRODUCT IDS      | STATUS |
+----------------------+------------------+--------+----------------------+--------+
| fd8fcf33nc0kjftpnrci | debian-11-docker |        | f2eh2keamkps7ekhfjge | READY  |
+----------------------+------------------+--------+----------------------+--------+

> aleksandrov_sp@aleksandrov-sp-dev:~/packer$ yc compute image get fd8fcf33nc0kjftpnrci
id: fd8fcf33nc0kjftpnrci
folder_id: b1g18m3fmokhkjuqb2r2
created_at: "2025-07-06T12:44:55Z"
name: debian-11-docker
description: my custom debian with docker
storage_size: "3409969152"
min_disk_size: "10737418240"
product_ids:
  - f2eh2keamkps7ekhfjge
status: READY
os:
  type: LINUX
hardware_generation:
  legacy_features:
    pci_topology: PCI_TOPOLOGY_V1
```

## 4. Создайте новую ВМ (минимальные параметры) в облаке, используя данный образ.

> aleksandrov_sp@aleksandrov-sp-dev:~/packer$ yc compute instance create --name my-first-vm --create-boot-disk name=debian-11-docker,size=20G,image-id=fd8fcf33nc0kjftpnrci --network-interface subnet-name=my-subnet-a,nat-ip-version=ipv4 --zone ru-central1-a --memory=2G --cores=2 --ssh-key /home/aleksandrov_sp/.ssh/id_ed25519.pub


## 5. Подключитесь по ssh и убедитесь в наличии установленного docker.
```
> aleksandrov_sp@aleksandrov-sp-dev:~/packer$ ssh yc-user@<IP-адрес Виртуальной машины>
> yc-user@fhmhrlig2t5u9d1lt55k:~$ docker --version
Docker version 28.3.1, build 38b7060
```

## 6. Удалите ВМ и образ.

Узнаем ID созданой виртуальной машины
> yc compute instance list

Удаляем виртуальную машину
> yc compute instance delete <ID виртуальной машины>

Узнаем ID созданного образа
> yc compute image list

Удаляем виртуальную машину
> yc compute image delete <ID созданного образа>







