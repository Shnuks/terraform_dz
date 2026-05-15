<h1>Домашняя работа</h1>

<h3>Terraform и docker установлены</h3>

![alt text](img/image.png)

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

Неправильно указаана ссылка:

```bash
 name  = "example_${random_password.random_string_FAKE.resulT}"
```

Исправлено на:

```bash
name  = "example_${random_password.random_string.resulT}"
```





