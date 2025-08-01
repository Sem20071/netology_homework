## Задание 1
1. Возьмите код:
* из ДЗ к лекции 4,
* из демо к лекции 4.
2. Проверьте код с помощью tflint и checkov. Вам не нужно инициализировать этот проект.
3. Перечислите, какие типы ошибок обнаружены в проекте (без дублей).


## Ответ:
Вывод инструмента tflint указывает на 3 основных типа предупреждений.
1. Warning: Missing version constraint for provider "random" in `required_providers` (terraform_required_providers)
Не указана минимальная версия провайдера, в данном случае провайдера "random" 

2. Warning: Module source "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main" uses a default branch as ref (main) (terraform_module_pinned_source)
Риск изменения версии модуля в репозитории. Рекомендует зафиксировать версию.

3. Warning: [Fixable] variable "public_key" is declared but not used (terraform_unused_declarations)
Переменная объявлена но нигде не используется.




