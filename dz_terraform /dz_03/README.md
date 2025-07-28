### Ссылка на созданную ветку terraform-03
### https://github.com/Sem20071/netology_homework/tree/terraform-03/dz_terraform%20/dz_03
## Задание 1
1. Изучите проект.
2. Инициализируйте проект, выполните код. Приложите скриншот входящих правил «Группы безопасности» в ЛК Yandex Cloud .

## Ответ:
![Скриншот консоли](https://github.com/Sem20071/netology_homework/blob/main/dz_terraform%20/dz_03/images/terraform-03-01-1.png).

## Задание 2
1. Создайте файл count-vm.tf. Опишите в нём создание двух одинаковых ВМ web-1 и web-2 (не web-0 и web-1) с минимальными параметрами, используя мета-аргумент count loop. Назначьте ВМ созданную в первом задании группу безопасности.(как это сделать узнайте в документации провайдера yandex/compute_instance )
2. Создайте файл for_each-vm.tf. Опишите в нём создание двух ВМ для баз данных с именами "main" и "replica" разных по cpu/ram/disk_volume , используя мета-аргумент for_each loop. Используйте для обеих ВМ одну общую переменную типа:
```
variable "each_vm" {
  type = list(object({  vm_name=string, cpu=number, ram=number, disk_volume=number }))
}
```
3. При желании внесите в переменную все возможные параметры.
4. ВМ из пункта 2.1 должны создаваться после создания ВМ из пункта 2.2.
5. Используйте функцию file в local-переменной для считывания ключа ~/.ssh/id_rsa.pub и его последующего использования в блоке metadata, взятому из ДЗ 2.
    Инициализируйте проект, выполните код.
   
## Ответ:
### 1. https://github.com/Sem20071/netology_homework/blob/terraform-03/dz_terraform%20/dz_03/count-vm.tf
### 2. https://github.com/Sem20071/netology_homework/blob/terraform-03/dz_terraform%20/dz_03/for_each-vm.tf
### 4. https://github.com/Sem20071/netology_homework/blob/terraform-03/dz_terraform%20/dz_03/locals.tf

## Задание 3
1. Создайте 3 одинаковых виртуальных диска размером 1 Гб с помощью ресурса yandex_compute_disk и мета-аргумента count в файле disk_vm.tf .
2. Создайте в том же файле одиночную(использовать count или for_each запрещено из-за задания №4) ВМ c именем "storage" . Используйте блок dynamic secondary_disk{..} и мета-аргумент for_each для подключения созданных вами дополнительных дисков.

## Ответ:
### https://github.com/Sem20071/netology_homework/blob/terraform-03/dz_terraform%20/dz_03/disk_vm.tf

## Задание 4
1. В файле ansible.tf создайте inventory-файл для ansible. Используйте функцию tepmplatefile и файл-шаблон для создания ansible inventory-файла из лекции. Готовый код возьмите из демонстрации к лекции demonstration2. Передайте в него в качестве переменных группы виртуальных машин из задания 2.1, 2.2 и 3.2, т. е. 5 ВМ.
2. Инвентарь должен содержать 3 группы и быть динамическим, т. е. обработать как группу из 2-х ВМ, так и 999 ВМ.
3. Добавьте в инвентарь переменную fqdn.

## Ответ:
![Скриншот консоли задание 4.](https://github.com/Sem20071/netology_homework/blob/main/dz_terraform%20/dz_03/images/terraform-03-04-1.png).

### Ссылка на созданную ветку terraform-03
### https://github.com/Sem20071/netology_homework/tree/terraform-03/dz_terraform%20/dz_03
