###cloud vars
/*variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}
*/

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "family_name" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "Type of the OS"
}
variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}
variable "vm_ssh_user" {
  type        = string
  description = "Default SSH user for Ubuntu images"
  default     = "ubuntu"
}
variable "vm_count" {
  type        = number
  description = "Number vm"
  default     = 2
}
variable "platform_id" {
  type        = string
  description = "Platform ID for vm"
  default     = "standard-v1"
}

variable "vm_res" {
  type = object({
    cores         = number
    memory        = number
    core_fraction = number
    disk_volume   = number
    disk_type     = string
  })

  default = {
    cores         = 2
    memory        = 2
    core_fraction = 5
    disk_volume   = 10
    disk_type     = "network-hdd"
  }
}


# each

variable "each_vm" {
  type = list(object({
    vm_name     = string
    cpu         = number
    ram         = number
    disk_volume = number
  }))

  default = [
    {
      vm_name     = "main"
      cpu         = 2
      ram         = 2
      disk_volume = 10
    },
    {
      vm_name     = "replica"
      cpu         = 2
      ram         = 4
      disk_volume = 20
    }
  ]
}
variable "vm_core_fraction" {
  type        = number
  description = "Core fraction for vm"
  default     = 20
}
variable "vm_disk_type" {
  type        = string
  description = "Disk type for vm"
  default     = "network-hdd"
}

variable "storage_vm_name" {
  type        = string
  description = "Storage VM name"
  default     = "storage"
}

variable "storage_vm_platform_id" {
  type        = string
  description = "Platform ID VM"
  default     = "standard-v1"
}

variable "storage_vm_resources" {
  type = object({
    cores         = number
    memory        = number
    core_fraction = number
    disk_volume   = number
    disk_type     = string
  })

  description = "Resources for storage VM"

  default = {
    cores         = 2
    memory        = 2
    core_fraction = 5
    disk_volume   = 10
    disk_type     = "network-hdd"
  }
}

variable "storage_disk_count" {
  type        = number
  description = "Number disks storage VM"
  default     = 3
}

variable "storage_disk_size" {
  type        = number
  description = "storage disk size"
  default     = 1
}

variable "storage_disk_type" {
  type        = string
  description = "storage disk type"
  default     = "network-hdd"
}
