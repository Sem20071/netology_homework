На основе ранее полученых навыков , при помощи Packer был создан образ будующе операционной системы на основе ОС Ubuntu 24.04. Листинг 
```
"builders": [
        {
            "type": "yandex",
            "token": "y0__xC55vOuARjB3RMg_4Oo3RO7Qsb04Boo6M6Ymy**************",
            "folder_id": "b1g18m3fmokhkju*****",
            "zone": "ru-central1-a",
            "image_name": "fd8jfh73rvks3qlqp3ck",
            "image_description": "my custom ubuntu2404 with docker",
            "source_image_family": "ubuntu-2404-lts-oslogin",
            "subnet_id": "e9b01c6stm7********",
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
              "sudo install -m 0755 -d /etc/apt/keyrings",
              "sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc",
              "sudo chmod a+r /etc/apt/keyrings/docker.asc",
              "echo \"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian bullseye stable\" | sudo tee /etc/apt/sources.list.d>
              "sudo apt-get update",
              "sudo apt-get install -y htop",
              "sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin"
            ]
        }
    ]

```
