# Задача 1
Сценарий выполнения задачи:

* Установите docker и docker compose plugin на свою linux рабочую станцию или ВМ.
* Если dockerhub недоступен создайте файл /etc/docker/daemon.json с содержимым: {"registry-mirrors": ["https://mirror.gcr.io", "https://daocloud.io", "https://c.163.com/", "https://registry.docker-cn.com"]}
* Зарегистрируйтесь и создайте публичный репозиторий с именем "custom-nginx" на https://hub.docker.com (ТОЛЬКО ЕСЛИ У ВАС ЕСТЬ ДОСТУП);
* скачайте образ nginx:1.21.1;
* Создайте Dockerfile и реализуйте в нем замену дефолтной индекс-страницы(/usr/share/nginx/html/index.html), на файл index.html с содержимым:
<html>
<head>
Hey, Netology
</head>
<body>
<h1>I will be DevOps Engineer!</h1>
</body>
</html>
* Соберите и отправьте созданный образ в свой dockerhub-репозитории c tag 1.0.0 (ТОЛЬКО ЕСЛИ ЕСТЬ ДОСТУП).
### * Предоставьте ответ в виде ссылки на https://hub.docker.com/<username_repo>/custom-nginx/general .

## Ответ:
## https://hub.docker.com/r/aleksandrovsp/custom-nginx/tags


# Задача 2
1. Запустите ваш образ custom-nginx:1.0.0 командой docker run в соответвии с требованиями:
* имя контейнера "ФИО-custom-nginx-t2"
* контейнер работает в фоне
* контейнер опубликован на порту хост системы 127.0.0.1:8080
2. Не удаляя, переименуйте контейнер в "custom-nginx-t2"
3. Выполните команду date +"%d-%m-%Y %T.%N %Z" ; sleep 0.150 ; docker ps ; ss -tlpn | grep 127.0.0.1:8080  ; docker logs custom-nginx-t2 -n1 ; docker exec -it custom-nginx-t2 base64 /usr/share/nginx/html/index.html
4. Убедитесь с помощью curl или веб браузера, что индекс-страница доступна.

###В качестве ответа приложите скриншоты консоли, где видно все введенные команды и их вывод.

## Ответ:

## https://github.com/Sem20071/netology_homework/blob/main/dz_05-virt-03-docker-intro/images/dz_05-virt-03-docker-intro-02.png

# Задача 3
1. Воспользуйтесь docker help или google, чтобы узнать как подключиться к стандартному потоку ввода/вывода/ошибок контейнера "custom-nginx-t2".
2. Подключитесь к контейнеру и нажмите комбинацию Ctrl-C.
3. Выполните docker ps -a и объясните своими словами почему контейнер остановился.
4. Перезапустите контейнер
5. Зайдите в интерактивный терминал контейнера "custom-nginx-t2" с оболочкой bash.
6. Установите любимый текстовый редактор(vim, nano итд) с помощью apt-get.
7. Отредактируйте файл "/etc/nginx/conf.d/default.conf", заменив порт "listen 80" на "listen 81".
8. Запомните(!) и выполните команду nginx -s reload, а затем внутри контейнера curl http://127.0.0.1:80 ; curl http://127.0.0.1:81.
9. Выйдите из контейнера, набрав в консоли exit или Ctrl-D.
10. Проверьте вывод команд: ss -tlpn | grep 127.0.0.1:8080 , docker port custom-nginx-t2, curl http://127.0.0.1:8080. Кратко объясните суть возникшей проблемы.
11. * Это дополнительное, необязательное задание. Попробуйте самостоятельно исправить конфигурацию контейнера, используя доступные источники в интернете. Не изменяйте конфигурацию nginx и не удаляйте контейнер.  Останавливать контейнер можно. пример источника
12. Удалите запущенный контейнер "custom-nginx-t2", не останавливая его.(воспользуйтесь --help или google)

### В качестве ответа приложите скриншоты консоли, где видно все введенные команды и их вывод.

## Ответ:
### Пункт 1-3
## https://github.com/Sem20071/netology_homework/blob/main/dz_05-virt-03-docker-intro/images/dz_05-virt-03-docker-intro-03-1.png
Для подключения к стандартному потоку ввода/вывода/ошибок контейнера используем команду Docker attach
После подключения к контейнеру и нажатия комбинации Ctrl-C, контейнер останавливается т.к. командой docker attach мы подключаемся к уже запущенному процессу, и при нажатии комбинации Ctrl-C процесс завершается и контейнер останавливается.

### Пункт 4-10
## https://github.com/Sem20071/netology_homework/blob/main/dz_05-virt-03-docker-intro/images/dz_05-virt-03-docker-intro-03-3-1.png
## https://github.com/Sem20071/netology_homework/blob/main/dz_05-virt-03-docker-intro/images/dz_05-virt-03-docker-intro-03-3-2.png
На 7ом шаге мы исправили конфигурацию nginx, а именно порт который слушает nginx, с 80 на 81. Но маппинг порта с хостовой машины остался прежним 8080:80. Как слеждствие мы не можем отрыть нашу страницу т.к. обращаясь к http://127.0.0.1:8080 на хостовой машине, мы попадаем на 80 порт контейнера, а там его никто не слушает.

### Пункт 11
Для настройки маппинга портов , без удаления контенера, необходимо сделать:
1. Узнаем идентификатор нашего контейнера.
   > docker inspect --format="{{.Id}}" custom-nginx-t2
2. Останавливаем контенер (КонтейнерЫ если он у на не один, т.к. на следующем шаге мы будем останавливать службу Docker)
   > docker stop custom-nginx-t2
3. Останавливаем службу Docker
   > systemctl stop docker.service
4. В каталоге /var/lib/docker/containers находим каталог с именем соответствующем идентификатуру нашего контенера и перходим в него
   > cd /var/lib/docker/containers/<ID нашего контейнера>
5. Находи в этом каатлоге файл hostconfig.json и правим в нем параметр PortBindings (В нашем случае с 80 на 81, именно 81 порт мы указали в конфигурации nginx). Не заьываем сохронить изменения.
6. В этом же каталоге находим файл config.v2.json и правим в нем параметр ExposedPorts (В нашем случае с 80 на 81, именно 81 порт мы указали в конфигурации nginx). Не заьываем сохронить изменения.
7. Запускаем службу docker.
8. Запускаем наш контейнер. Проверяем маппинг портови пробуем выполнить команду curl http://127.0.0.1:8080. Если curl нам отдал структуру страницы, мы всё сделали верно. УСПЕХ !!

## https://github.com/Sem20071/netology_homework/blob/main/dz_05-virt-03-docker-intro/images/dz_05-virt-03-docker-intro-03-3-3.png

## Пункт 12
Для удаления контейнера бз его остановки можно использовать стандартную команду docker rm <имя контейнера> с ключём -f
> docker rm -f custom-nginx-t2

## Задание 4.
* Запустите первый контейнер из образа centos c любым тегом в фоновом режиме, подключив папку текущий рабочий каталог $(pwd) на хостовой машине в /data контейнера, используя ключ -v.
* Запустите второй контейнер из образа debian в фоновом режиме, подключив текущий рабочий каталог $(pwd) в /data контейнера.
* Подключитесь к первому контейнеру с помощью docker exec и создайте текстовый файл любого содержания в /data.
* Добавьте ещё один файл в текущий каталог $(pwd) на хостовой машине.
* Подключитесь во второй контейнер и отобразите листинг и содержание файлов в /data контейнера.
### В качестве ответа приложите скриншоты консоли, где видно все введенные команды и их вывод.

## Ответ:
## https://github.com/Sem20071/netology_homework/blob/main/dz_05-virt-03-docker-intro/images/dz_05-virt-03-docker-intro-03-4-1.png

## Задание 5.

1. Создайте отдельную директорию(например /tmp/netology/docker/task5) и 2 файла внутри него. "compose.yaml" с содержимым:
```
version: "3"
services:
  portainer:
    network_mode: host
    image: portainer/portainer-ce:latest
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
```
"docker-compose.yaml" с содержимым:
```
version: "3"
services:
  registry:
    image: registry:2

    ports:
    - "5000:5000"
```
И выполните команду "docker compose up -d". Какой из файлов был запущен и почему? (подсказка: https://docs.docker.com/compose/compose-application-model/#the-compose-file )

2. Отредактируйте файл compose.yaml так, чтобы были запущенны оба файла. (подсказка: https://docs.docker.com/compose/compose-file/14-include/)

3. Выполните в консоли вашей хостовой ОС необходимые команды чтобы залить образ custom-nginx как custom-nginx:latest в запущенное вами, локальное registry. Дополнительная документация: https://distribution.github.io/distribution/about/deploying/

4. Откройте страницу "https://127.0.0.1:9000" и произведите начальную настройку portainer.(логин и пароль адмнистратора)

5. Откройте страницу "http://127.0.0.1:9000/#!/home", выберите ваше local окружение. Перейдите на вкладку "stacks" и в "web editor" задеплойте следующий компоуз:
```
version: '3'

services:
  nginx:
    image: 127.0.0.1:5000/custom-nginx
    ports:
      - "9090:80"
```
6. Перейдите на страницу "http://127.0.0.1:9000/#!/2/docker/containers", выберите контейнер с nginx и нажмите на кнопку "inspect". В представлении <> Tree разверните поле "Config" и сделайте скриншот от поля "AppArmorProfile" до "Driver".

7. Удалите любой из манифестов компоуза(например compose.yaml). Выполните команду "docker compose up -d". Прочитайте warning, объясните суть предупреждения и выполните предложенное действие. Погасите compose-проект ОДНОЙ(обязательно!!) командой.

В качестве ответа приложите скриншоты консоли, где видно все введенные команды и их вывод, файл compose.yaml , скриншот portainer c задеплоенным компоузом.

## Ответ:

## Пункт 1
## https://github.com/Sem20071/netology_homework/blob/main/dz_05-virt-03-docker-intro/images/dz_05-virt-03-docker-intro-03-5-1.png
Был заупщен файл Compose.yaml т.к. он считается более приоритетным.

## Пункт 2
## https://github.com/Sem20071/netology_homework/blob/main/dz_05-virt-03-docker-intro/images/dz_05-virt-03-docker-intro-03-5-2.png

## Пункт 3
## https://github.com/Sem20071/netology_homework/blob/main/dz_05-virt-03-docker-intro/images/dz_05-virt-03-docker-intro-03-5-3.png

## Пункт 4-5
## https://github.com/Sem20071/netology_homework/blob/main/dz_05-virt-03-docker-intro/images/dz_05-virt-03-docker-intro-03-5-5.png

## Пункт 6
## https://github.com/Sem20071/netology_homework/blob/main/dz_05-virt-03-docker-intro/images/dz_05-virt-03-docker-intro-03-5-6.png

## Пункт 7
Warning нам сообщает что проект был изменен некоторые контейнеры более не определены в настройках проекта docker-compose. Так же он предлагает нам удалить контенеры которые более не определены в docker-compose проекте.  Остановить и удалить такие контенеры можно при помощи команды:
> docker-compose down --remove-orphans.

## https://github.com/Sem20071/netology_homework/blob/main/dz_05-virt-03-docker-intro/images/dz_05-virt-03-docker-intro-03-5-7.png
