
variable "vm_web_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "OC version"
}
/* variable "vm_web_name" {
  type        = string
  default     = "netology-develop-platform-web"
  description = "name VM"
}
*/
variable "vm_web_platform_id" {
  type        = string
  default     = "standard-v1"
  description = "platform_id"
}
/*
variable "vm_web_cores" {
  type        = string
  default     = "2"
  description = "CPU"
}
variable "vm_web_memory" {
  type        = string
  default     = "2"
  description = "memory GB"
}
variable "vm_web_core_fraction" {
  type        = string
  default     = "5"
  description = "core_fraction %"
}

*/
variable "vm_db_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "OC version"
}
/*
variable "vm_db_name" {
  type        = string
  default     = "netology-develop-platform-db"
  description = "name VM"
}
*/

variable "vm_db_platform_id" {
  type        = string
  default     = "standard-v1"
  description = "platform_id"
}

/*
variable "vm_db_cores" {
  type        = string
  default     = "2"
  description = "CPU"
}
variable "vm_db_memory" {
  type        = string
  default     = "2"
  description = "memory GB"
}
variable "vm_db_core_fraction" {
  type        = string
  default     = "5"
  description = "core_fraction %"
}
*/

variable "project_prefix" {
  description = "Prefix project"
  type        = string
}

variable "environment" {
  description = "env"
  type        = string
}



variable "vm_res" {
  description = "Ресурсы для вм (web и db)"
  type = map(object({
    cores         = number
    memory        = number
    core_fraction = number
    hdd_size      = number
    hdd_type      = string
  }))
}

variable "metadata" {
  description = "Общие метаданные для всех ВМ"
  type = object({
    serial-port-enable = number
    ssh-keys           = string
  })
}
