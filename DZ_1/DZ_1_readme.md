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


