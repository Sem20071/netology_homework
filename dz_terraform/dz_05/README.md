## Задание 1
1. Возьмите код:
* из ДЗ к лекции 4,
* из демо к лекции 4.
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
