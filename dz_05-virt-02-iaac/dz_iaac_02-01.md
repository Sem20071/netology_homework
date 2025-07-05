Задача 1
Установите на личный Linux-компьютер или учебную локальную ВМ с Linux следующие сервисы(желательно ОС ubuntu 20.04):

* VirtualBox,
  > sudo apt install virtualbox
  
* Vagrant, рекомендуем версию 2.3.4                                 ## Последняя версия в репозитории убунту 2.2.6. Скачал и установил deb пакет 2.3.4 версии с оффициального репозитория hashicorp.
  > sudo apt install vagrant                                        ## sudo dpkg -i vagrant_2.3.4-1_amd64.deb
  
* Packer версии 1.9.х + плагин от Яндекс Облако по инструкции       ## Последняя версия в репозитории убунту 1.3.4. Скачал и установил deb пакет 2.3.4 версии с оффициального репозитория hashicorp.
  > sudo apt install packer
  
* уandex cloud cli Так же инициализируйте профиль с помощью yc init .
  > curl -sSL https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash
  
  После завершения установки перезапустите командную оболочку
  > exec bash

aleksandrov_sp@aleksandrov-sp-dev:~/vagrant$ VBoxManage --version
6.1.50_Ubuntur161033

aleksandrov_sp@aleksandrov-sp-dev:~/vagrant$ vagrant --version
Vagrant 2.3.4

aleksandrov_sp@aleksandrov-sp-dev:~/vagrant$ packer --version
1.3.4
