# Задача 1
Создайте ваш первый Docker Swarm-кластер в Яндекс Облаке. Документация swarm: https://docs.docker.com/engine/reference/commandline/swarm_init/
1. Создайте 3 облачные виртуальные машины в одной сети.
2. Установите docker на каждую ВМ.
3. Создайте swarm-кластер из 1 мастера и 2-х рабочих нод.
4. Проверьте список нод командой:****

# Ответ
## 1.Создайте 3 облачные виртуальные машины в одной сети.
Через Packer был создан образ в YC. Образ уже включает в себя актуальную версию Docker и Docker-compose.

```
 "builders": [
        {
            "type": "yandex",
            "token": "y0__xC55vOuARjB3RMg_4Oo3RO7Qsb04Boo6M********",
            "folder_id": "b1g18m3fmokh******",
            "zone": "ru-central1-a",
            "image_name": "fd8jfh73rvks3qlqp3ck",
            "image_description": "my custom ubuntu2404 with docker",
            "source_image_family": "ubuntu-2404-lts-oslogin",
            "subnet_id": "e9b01c6stm7p7bd****",
            "use_ipv4_nat": true,
            "disk_type": "network-hdd",
            "ssh_username": "ubuntu"
        }
    ],
    "provisioners": [
        {
            "type": "shell",
            "inline": [
              "sudo apt-get update",
              "sudo apt-get install -y ca-certificates curl git",
              "sudo curl -fsSL get.docker.com -o get-docker.sh && sudo chmod +x get-docker.sh && sudo ./get-docker.sh",
              "sudo apt-get install -y htop"
            ]
        }
    ]
```
На основе образа были развернуты 3 ВМ.
1) yc compute instance create --name aleksandrov-sp-manager-01 --create-boot-disk name=ubuntu-manager-01,image-id=fd89sidsik6nna6job0o,size=15,type=network-hdd --network-interface subnet-name=my-subnet-a,nat-ip-version=ipv4 --zone ru-central1-a --memory=2G --cores=2 --core-fraction=20 --preemptible --ssh-key /home/aleksandrov_sp/.ssh/id_ed25519.pub
2) yc compute instance create --name aleksandrov-sp-worker-01 --create-boot-disk name=ubuntu-worker-01,image-id=fd89sidsik6nna6job0o,size=15,type=network-hdd --network-interface subnet-name=my-subnet-a,nat-ip-version=ipv4 --zone ru-central1-a --memory=2G --cores=2 --core-fraction=20 --preemptible --ssh-key /home/aleksandrov_sp/.ssh/id_ed25519.pub
3) yc compute instance create --name aleksandrov-sp-worker-02 --create-boot-disk name=ubuntu-worker-02,image-id=fd89sidsik6nna6job0o,size=15,type=network-hdd --network-interface subnet-name=my-subnet-a,nat-ip-version=ipv4 --zone ru-central1-a --memory=2G --cores=2 --core-fraction=20 --preemptible --ssh-key /home/aleksandrov_sp/.ssh/id_ed25519.pub

### https://github.com/Sem20071/netology_homework/blob/main/dz_05-virt-05-docker-swarm/images/dz_05-virt-05-docker-swarm-01-01.png

## 2. Установите docker на каждую ВМ. 
Актуальная версия Docker и Docker-compose были в созданом образе, и уже установлены в ВМ.
### https://github.com/Sem20071/netology_homework/blob/main/dz_05-virt-05-docker-swarm/images/dz_05-virt-05-docker-swarm-01-02.png

## 3. Создайте swarm-кластер из 1 мастера и 2-х рабочих нод.
### https://github.com/Sem20071/netology_homework/blob/main/dz_05-virt-05-docker-swarm/images/dz_05-virt-05-docker-swarm-01-03.png

## 4. Проверьте список нод командой docker node ls
### https://github.com/Sem20071/netology_homework/blob/main/dz_05-virt-05-docker-swarm/images/dz_05-virt-05-docker-swarm-01-04.png



