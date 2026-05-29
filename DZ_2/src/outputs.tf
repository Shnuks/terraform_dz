output "vm_instances_info" {
  description = "Информация о вм: имя и внешний IP"
  value = {
    web_vm = {
      instance_name = yandex_compute_instance.platform.name
      external_ip   = yandex_compute_instance.platform.network_interface[0].nat_ip_address
    },
    db_vm = {
      instance_name = yandex_compute_instance.platform_2.name
      external_ip   = yandex_compute_instance.platform_2.network_interface[0].nat_ip_address
    }
  }
}