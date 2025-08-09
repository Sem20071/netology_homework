#Создание кластера MySQL
resource "yandex_mdb_mysql_cluster" "prod-mysql" {
  name        = var.db_cluster_name
  environment = "PRODUCTION"
  network_id  = module.vpc_prod_module.network_prod.id
  version     = "8.0"
  security_group_ids = [module.vpc_prod_module.vpc_security_group_prod.id]
  depends_on = [module.vpc_prod_module]
  resources {
    resource_preset_id = var.db_resources_preset
    disk_type_id       = var.disk_type_db
    disk_size          = 10
  }

  host {
    zone      = var.vpc_subnet_zone #"ru-central1-a"
    subnet_id = module.vpc_prod_module.subnet_prod_a.id
    assign_public_ip = true
  }


  maintenance_window {         # Настройка обслуживания. Резервного копирования
    type = "WEEKLY"
    day  = "SAT"
    hour = 12
  }

  access {
    web_sql = true
  }

  deletion_protection = false   # Защита от удаления !
}

# Создание базы данных в кластере
resource "yandex_mdb_mysql_database" "example" {
  cluster_id = yandex_mdb_mysql_cluster.prod-mysql.id
  name       = var.db_name
}

# Создание пользователя БД
resource "yandex_mdb_mysql_user" "app-user" {
  cluster_id = yandex_mdb_mysql_cluster.prod-mysql.id
  name       = var.db_user
  password   = var.db_pass

   permission {
    database_name = yandex_mdb_mysql_database.example.name
    roles         = ["ALL"]
  }
}

output "mysql_host" {
  value = yandex_mdb_mysql_cluster.prod-mysql.host[0].fqdn
}