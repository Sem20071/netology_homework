## Задание 1
1. Возьмите код:
- из ДЗ к лекции 4,
- из демо к лекции 4.
2. Проверьте код с помощью tflint и checkov. Вам не нужно инициализировать этот проект.
3. Перечислите, какие типы ошибок обнаружены в проекте (без дублей).


## Ответ:
Вывод инструмента tflint указывает на 3 типа проблем нашего кода.
1. Warning: Missing version constraint for provider "random" in `required_providers` (terraform_required_providers)
Не указана минимальная версия провайдера, в данном случае провайдера "random" 

2. Warning: Module source "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main" uses a default branch as ref (main) (terraform_module_pinned_source)
Риск изменения версии модуля в репозитории. Рекомендует зафиксировать версию.

3. Warning: [Fixable] variable "public_key" is declared but not used (terraform_unused_declarations)
Переменная объявлена но нигде не используется.

Вывод инструмента checkov указывает на 2 типа проблем нашего кода.
1. Check: CKV_TF_2: "Ensure Terraform module sources use a tag with a version number" 
2. Check: CKV_TF_1: "Ensure Terraform module sources use a commit hash"
Эти два предупреждения схожи, и направлены на фиксацию версии модуля. В первом случае виксация версии через тэг, во втором случая виксация версия более строгая через хэш коммита.

## Задание 2
1. Возьмите ваш GitHub-репозиторий с выполненным ДЗ 4 в ветке 'terraform-04' и сделайте из него ветку 'terraform-05'.
2. Повторите демонстрацию лекции: настройте YDB, S3 bucket, yandex service account, права доступа и мигрируйте state проекта в S3 с блокировками. Предоставьте скриншоты процесса в качестве ответа.
3. Закоммитьте в ветку 'terraform-05' все изменения.
4. Откройте в проекте terraform console, а в другом окне из этой же директории попробуйте запустить terraform apply.
5. Пришлите ответ об ошибке доступа к state.
6. Принудительно разблокируйте state. Пришлите команду и вывод.

## Ответ:
   ### 1 - 2. Скриншот. Создан бакет, назначены парва доступа сервисной УЗ.
   ![Скриншот](https://github.com/Sem20071/netology_homework/blob/main/dz_terraform/dz_05/images/terraform-05-02-1.png)
   ###Скриншот. Создана база данных.
   ![Скриншот](https://github.com/Sem20071/netology_homework/blob/main/dz_terraform/dz_05/images/terraform-05-02-2.png)
   ###Скриншот.Создана таблица блокировок state.
   ![Скриншот](https://github.com/Sem20071/netology_homework/blob/main/dz_terraform/dz_05/images/terraform-05-02-3.png)
   ### Скриншот. State паранесен в backend s3.
   ![Скриншот](https://github.com/Sem20071/netology_homework/blob/main/dz_terraform/dz_05/images/terraform-05-02-5.png)

  ### 3 - 6. Ошибка блокировка state. Принудительная раблокировка state.
   ![Скриншот](https://github.com/Sem20071/netology_homework/blob/main/dz_terraform/dz_05/images/terraform-05-02-6.png)


## Задание 3
1. Сделайте в GitHub из ветки 'terraform-05' новую ветку 'terraform-hotfix'.
2. Проверье код с помощью tflint и checkov, исправьте все предупреждения и ошибки в 'terraform-hotfix', сделайте коммит.
3. Откройте новый pull request 'terraform-hotfix' --> 'terraform-05'.
4. Вставьте в комментарий PR результат анализа tflint и checkov, план изменений инфраструктуры из вывода команды terraform plan.
5. Пришлите ссылку на PR для ревью. Вливать код в 'terraform-05' не нужно.

   ## Ответ:

### [Ссылка на PR ветки terraform-hotfix](https://github.com/Sem20071/netology_homework/pull/2)

## Задание 4

1. Напишите переменные с валидацией и протестируйте их, заполнив default верными и неверными значениями. Предоставьте скриншоты проверок из terraform console.
- type=string, description="ip-адрес" — проверка, что значение переменной содержит верный IP-адрес с помощью функций cidrhost() или regex(). Тесты: "192.168.0.1" и "1920.1680.0.1";
- type=list(string), description="список ip-адресов" — проверка, что все адреса верны. Тесты: ["192.168.0.1", "1.1.1.1", "127.0.0.1"] и ["192.168.0.1", "1.1.1.1", "1270.0.0.1"].
   
## Ответ:
Вводим верный формат адреса(ов) в дефолтные значения переменных.
![Скриншот](https://github.com/Sem20071/netology_homework/blob/main/dz_terraform/dz_05/images/terraform-05-04-1.png)
![Скриншот](https://github.com/Sem20071/netology_homework/blob/main/dz_terraform/dz_05/images/terraform-05-04-2-1.png)
Вводим НЕверный формат адреса(ов) в дефолтные значения переменных. Наблюдаем ошибку.
![Скриншот](https://github.com/Sem20071/netology_homework/blob/main/dz_terraform/dz_05/images/terraform-05-04-1-2.png)
![Скриншот](https://github.com/Sem20071/netology_homework/blob/main/dz_terraform/dz_05/images/terraform-05-04-2-2.png)


