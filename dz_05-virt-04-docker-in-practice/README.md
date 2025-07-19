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
1. https://github.com/Sem20071/netology_homework/blob/main/dz_05-virt-04-docker-in-practice/images/dz_05-virt-04-docker-in-practice-1-1.png
2. https://github.com/Sem20071/netology_homework/blob/main/dz_05-virt-04-docker-in-practice/images/dz_05-virt-04-docker-in-practice-01-2.png
3. https://github.com/Sem20071/netology_homework/blob/main/dz_05-virt-04-docker-in-practice/images/dz_05-virt-04-docker-in-practice-01-3.png
