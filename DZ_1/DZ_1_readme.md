<h1>Домашняя работа</h1>

<h3>Terraform и docker установлены</h3>

<img width="451" height="159" alt="изображение" src="https://github.com/user-attachments/assets/28d0d4be-e1c6-4a6e-b3f0-c53a988797df" />


<h2>Задание 1</h2>
<h4>1) Каталог скопирован</h4> 
<h4>2) Cогласно .gitignore, допустимо сохранить личную, секретную информацию в файле </h4>


```bash
personal.auto.tfvars 
```
<h4>3) В исходном файле ограничение по версии terraform, а т.к. установлена версия 1.14.9, был изменен код</h4>
Было

```bash
required_version = "~>1.12.0"
```
Стало

```bash
required_version = ">=1.12.0"
```
Также было необходимо изменить значение переменной TF_CLI_CONFIG_FILE, т.к. Terraform по умолчанию ищет файл .terraformrc в корне

```bash
export TF_CLI_CONFIG_FILE=/home/terraform_user/01/src/.terraformrc 
```
Результат запуска кода проекта: 
   
<img width="781" height="611" alt="изображение" src="https://github.com/user-attachments/assets/422f3100-cdb8-4952-a4fe-7175b5cb49cd" />
   
Секретное содержимое созданного ресурса random_password:
    
```bash
1JmQn7ujLkXB5y8H
```
<img width="809" height="669" alt="изображение" src="https://github.com/user-attachments/assets/4ffcf502-8890-4aa7-961c-3e0b444527a8" />
   

<h4>4) Результат команды terraform validate</h4>
   
<img width="812" height="310" alt="изображение" src="https://github.com/user-attachments/assets/83e6d43b-8af1-4273-badf-401566ee0488" />
   

<h5>Выявлены 3 намеренно допущенные ошибки</h5>

<h5>Ошибка 1 </h5>
   
Не указано локальное имя по структуре:
   

```bash
resource "<TYPE>" "<LOCAL_NAME>" {
```
Исправлено:

```bash
resource "docker_image" "nginx"{
  name         = "nginx:latest"
  keep_locally = true
}
```

<h5>Ошибка 2 </h5>
  
Некорректное имя ресурса (начало с цифры)
   
```bash
resource "docker_container" "1nginx" {
```

Исправлено на:

```bash
resource "docker_container" "nginx" {
```

<h5>Ошибка 3</h5>

   <img width="758" height="146" alt="изображение" src="https://github.com/user-attachments/assets/7924906d-7213-4ce3-9081-be24e9c82b38" />

Неправильно указана ссылка:

```bash
 name  = "example_${random_password.random_string_FAKE.resulT}"
```

Исправлено на:
c


<h4>5) Исправленный вариант кода:</h4>
   
```bash
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
    }
  }
  required_version = ">=1.12.0" /*Многострочный комментарий.
 Требуемая версия terraform */
}
provider "docker" {}

#однострочный комментарий

resource "random_password" "random_string" {
  length      = 16
  special     = false
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
}


resource "docker_image" "nginx"{
  name         = "nginx:latest"
  keep_locally = true
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = "example_${random_password.random_string.result}"

  ports {
    internal = 80
    external = 9090
  }
}



```

<img width="978" height="67" alt="изображение" src="https://github.com/user-attachments/assets/08007861-b694-42a8-af3b-d70f9c53097b" />



<h4>6) Замена имени docker-контейнера в блоке кода на hello_world </h4>

```bash
resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = "Hello_world"
```

Ответ на вопрос:

-auto-approve в основном используется при автоматизации, в скриптах и т.п. из-за того, что есть необходимость запускать проект без подтверждения действия. Опасность данной команды заключается в том, при запуске проекта нет проверки плана из-за этого можно упустить ошибки или случайное удаление ресурсов.

   <img width="890" height="111" alt="изображение" src="https://github.com/user-attachments/assets/d5f39c30-b7f7-4619-9609-77eb04ae2174" />


<h4>7) Файл terraform.tfstate, после удаления проекта</h4>

   ```bash
{
  "version": 4,
  "terraform_version": "1.14.9",
  "serial": 11,
  "lineage": "5cf24314-8461-0c7b-d93d-0c6f415d487a",
  "outputs": {},
  "resources": [],
  "check_results": null
}

```

<h4>8) Docker-образ nginx:latest был не удален из-за того, что в конфигурационном файле пректа указано следующее: </h4>

```bash
resource "docker_image" "nginx"{
  name         = "nginx:latest"
  keep_locally = true
}
```

Строка **`keep_locally = true`** означает, что образ не будет удален при операции уничтожения 

Строчка из документации terraform провайдера docker:
   
**`keep_locally (Boolean) Если значение true, образ Docker не будет удален при операции уничтожения. Если значение false, образ будет удален из локального хранилища Docker при операции уничтожения.`**

<h2>Задание 2*</h2>
Задание выполнялось по следующему алгоритму:

Сначала в Yandex Cloud была развернута VM
   
<img width="1526" height="83" alt="изображение" src="https://github.com/user-attachments/assets/1ad8e3f5-3094-46f2-9bb6-a07d22c61208" />

Далее на нее была произведена установка terraform и docker
   
**`Установка Terraform:`**
   
```bash
wget https://hashicorp-releases.yandexcloud.net/terraform/1.14.9/terraform_1.14.9_linux_amd64.zip
unzip terraform_1.14.9_linux_amd64.zip
cp -r terraform /usr/local/bin
```

**`Установка Docker:`**
   
```bash
sudo apt update
sudo apt install -y docker.io
sudo systemctl enable docker
sudo usermod -aG docker <username>
```

Далее работы проводились на локальной ВМ. В директории home/ был создан проект со следующими файлами 

```bash
dz_project/
├── main.tf
├── variables.tf
├── personal.auto.tfvars
├── .gitignore
├── .terraformrc 
```

Файл **`personal.auto.tfvars`**

```bash
vm_ip = "130.193.54.35"
```


**`Наполнение файлов представлено в директории DZ_1/src_z2 `**

После на локальную ВМ были загружены SSH ключи **`ssh-key-1778845195639`** и **`ssh-key-1778845195639.pub`**

1) Добавление ключа в ssh-агент

```bash
ssh-add /home/user/.ssh/ssh-key-1778845195639
```

2) Настройка статического подключения

```bash
nano ~/.ssh/config
```


```bash
Host 130.193.54.35
  User terroform_user
  IdentityFile /home/user/.ssh/ssh-key-1778845195639
  IdentitiesOnly yes
```
   
```bash
chmod 644 /home/user/.ssh/ssh-key-1778845195639.pub
chmod 600 /home/user/.ssh/ssh-key-1778845195639
```

Следующим шагом был запуск проекта:

1) Инициализация проекта:

```bash
terraform init
```
2) Проверка плана:

```bash
terraform plan
```

3) Применение конфигурации:

```bash
terraform apply
yes
```
Результат:

<img width="859" height="337" alt="изображение" src="https://github.com/user-attachments/assets/d7230140-41f3-4700-aa61-190c00dafe36" />

4) Подключение к удаленной ВМ

```bash
ssh terroform_user@130.193.54.35
```

5) Проверка успешности запуска контейнера

```bash
docker ps
```

Результат:

<img width="1076" height="51" alt="изображение" src="https://github.com/user-attachments/assets/6f985d47-5032-4c5e-96d8-c2c4fbb42172" />

6) Проверка переменных


```bash
sudo docker exec -it mysql-db-Moj1CumtZwQHP7ru bash
env | grep MYSQ
```

Результат:

<img width="327" height="194" alt="изображение" src="https://github.com/user-attachments/assets/a3b734da-90bd-41bc-ae2f-17311b0f90e5" />

<h2>Задание 3*</h2>

   Для начала был снесен проект

<img width="781" height="376" alt="изображение" src="https://github.com/user-attachments/assets/5ef7a558-919d-461f-a2e1-4e5362ab0f46" />

Установка OpenTofy:

```bash
snap install --classic opentofu
```

Результат: 

<img width="483" height="122" alt="изображение" src="https://github.com/user-attachments/assets/6c711dc0-a940-4da9-ad4b-961c4f0a9a65" />

Дальше была очень муторная ностройка,т.к. init постоянно обращался в инет и ругался на соединие, поэтому пришлось установить провайдеров локально и запретить обращаться в интернет

Измененные файлы:

**`main.tf`**

```bash
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "4.3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.9.0"
    }
  }
}
```

Созданные файлы :

**`.tofurc`**

```bash

provider_installation {
  filesystem_mirror {
    path = "/home/dz_project/.tofu/providers"
  }
}
```

Важные команды: 


```bash
export TOFU_CLI_CONFIG_FILE=/home/dz_project/.tofurc
```







