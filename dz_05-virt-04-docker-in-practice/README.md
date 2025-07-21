## Задача 0
### Убедитесь что у вас НЕ(!) установлен docker-compose, для этого получите следующую ошибку от команды docker-compose --version

## Ответ
### https://github.com/Sem20071/netology_homework/blob/main/dz_05-virt-04-docker-in-practice/images/dz_05-virt-04-docker-in-practice-00-1.png

## Задача 1
1. Сделайте в своем GitHub пространстве fork репозитория.
2. Создайте файл Dockerfile.python на основе существующего Dockerfile:
3. Используйте базовый образ python:3.12-slim
* Обязательно используйте конструкцию COPY . . в Dockerfile
* Создайте .dockerignore файл для исключения ненужных файлов
* Используйте CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "5000"] для запуска
* Протестируйте корректность сборки
4. (Необязательная часть, *) Изучите инструкцию в проекте и запустите web-приложение без использования docker, с помощью venv. (Mysql БД можно запустить в docker run).
5. (Необязательная часть, *) Изучите код приложения и добавьте управление названием таблицы через ENV переменную.

## Ответ: 
### 1. https://github.com/Sem20071/netology_homework/blob/main/dz_05-virt-04-docker-in-practice/images/dz_05-virt-04-docker-in-practice-1-1.png
### 2. https://github.com/Sem20071/netology_homework/blob/main/dz_05-virt-04-docker-in-practice/images/dz_05-virt-04-docker-in-practice-01-2.png
### 3. https://github.com/Sem20071/netology_homework/blob/main/dz_05-virt-04-docker-in-practice/images/dz_05-virt-04-docker-in-practice-01-3.png
### * 4. https://github.com/Sem20071/netology_homework/blob/main/dz_05-virt-04-docker-in-practice/images/dz_05-virt-04-docker-in-practice-01-4.png
 

## Задача 3
1. Изучите файл "proxy.yaml"
2. Создайте в репозитории с проектом файл compose.yaml. С помощью директивы "include" подключите к нему файл "proxy.yaml".
3. Опишите в файле compose.yaml следующие сервисы:
* web. Образ приложения должен ИЛИ собираться при запуске compose из файла Dockerfile.python ИЛИ скачиваться из yandex cloud container registry(из задание №2 со *). Контейнер должен работать в bridge-сети с названием backend и иметь фиксированный ipv4-адрес 172.20.0.5. Сервис должен всегда перезапускаться в случае ошибок. Передайте необходимые ENV-переменные для подключения к Mysql базе данных по сетевому имени сервиса web
* db. image=mysql:8. Контейнер должен работать в bridge-сети с названием backend и иметь фиксированный ipv4-адрес 172.20.0.10. Явно перезапуск сервиса в случае ошибок. Передайте необходимые ENV-переменные для создания: пароля root пользователя, создания базы данных, пользователя и пароля для web-приложения.Обязательно используйте уже существующий .env file для назначения секретных ENV-переменных!
4. Запустите проект локально с помощью docker compose , добейтесь его стабильной работы: команда curl -L http://127.0.0.1:8090 должна возвращать в качестве ответа время и локальный IP-адрес. Если сервисы не стартуют воспользуйтесь командами: docker ps -a  и docker logs <container_name> . Если вместо IP-адреса вы получаете информационную ошибку --убедитесь, что вы шлете запрос на порт 8090, а не 5000.
5. Подключитесь к БД mysql с помощью команды docker exec -ti <имя_контейнера> mysql -uroot -p<пароль root-пользователя>(обратите внимание что между ключем -u и логином root нет пробела. это важно!!! тоже самое с паролем) . 6. Введите последовательно команды (не забываем в конце символ ; ): show databases; use <имя вашей базы данных(по-умолчанию example)>; show tables; SELECT * from requests LIMIT 10;.

Остановите проект. В качестве ответа приложите скриншот sql-запроса.

## Ответ: 
### https://github.com/Sem20071/netology_homework/blob/main/dz_05-virt-04-docker-in-practice/images/dz_05-virt-04-docker-in-practice-3-1.png

Результат выполнения SQL запроса:
### https://github.com/Sem20071/netology_homework/blob/main/dz_05-virt-04-docker-in-practice/images/dz_05-virt-04-docker-in-practice-3-2.png

## Задача 4
1. Запустите в Yandex Cloud ВМ (вам хватит 2 Гб Ram).
2. Подключитесь к Вм по ssh и установите docker.
3. Напишите bash-скрипт, который скачает ваш fork-репозиторий в каталог /opt и запустит проект целиком.
4. Зайдите на сайт проверки http подключений, например(или аналогичный): https://check-host.net/check-http и запустите проверку вашего сервиса http://<внешний_IP-адрес_вашей_ВМ>:8090. Таким образом трафик будет направлен в ingress-proxy. Трафик должен пройти через цепочки: Пользователь → Internet → Nginx → HAProxy → FastAPI(запись в БД) → HAProxy → Nginx → Internet → Пользователь
5. (Необязательная часть) Дополнительно настройте remote ssh context к вашему серверу. Отобразите список контекстов и результат удаленного выполнения docker ps -a
6. Повторите SQL-запрос на сервере и приложите скриншот и ссылку на fork.

## Ответ: 
Результат выполнения  запроса:
### https://github.com/Sem20071/netology_homework/blob/main/dz_05-virt-04-docker-in-practice/images/dz_05-virt-04-docker-in-practice-4-1.png
Ссылка на Fork-репозиторий:
### https://github.com/Sem20071/shvirtd-example-python#

5* Дополнительно настройте remote ssh context к вашему серверу. Отобразите список контекстов и результат удаленного выполнения docker ps -a
### https://github.com/Sem20071/netology_homework/blob/main/dz_05-virt-04-docker-in-practice/images/dz_05-virt-04-docker-in-practice-4-5.png

## Задача 6
Скачайте docker образ hashicorp/terraform:latest и скопируйте бинарный файл /bin/terraform на свою локальную машину, используя dive и docker save. Предоставьте скриншоты действий .

## Ответ:
В dive мы можем послойно рассмотреть образ docker и увидеть в каком слое добавляется интересующий нас файл. В "layer detail" нас интересует пункт "Digest".
### https://github.com/Sem20071/netology_homework/blob/main/dz_05-virt-04-docker-in-practice/images/dz_05-virt-04-docker-in-practice-6-1.png

Через docker save сохраняем наш образ в формате tar и распаковываем его. Находим внутри архив с именем соотвтетствующий параметру "Digest", и распаковываем его. Файл terraform из образа у нас на хостовой машине.
## https://github.com/Sem20071/netology_homework/blob/main/dz_05-virt-04-docker-in-practice/images/dz_05-virt-04-docker-in-practice-6-2.png

## Задача 6.1
Добейтесь аналогичного результата, используя docker cp.
Предоставьте скриншоты действий .

## Ответ:

### https://github.com/Sem20071/netology_homework/blob/main/dz_05-virt-04-docker-in-practice/images/dz_05-virt-04-docker-in-practice-6-1-1.png


