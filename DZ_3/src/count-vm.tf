resource "yandex_compute_instance" "web" {
  count = var.vm_count

  name        = "web-${count.index + 1}"
  hostname    = "web-${count.index + 1}"
  platform_id = var.platform_id
  zone        = var.default_zone

  resources {
    cores         = var.vm_res.cores
    memory        = var.vm_res.memory
    core_fraction = var.vm_res.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = var.vm_res.disk_volume
      type     = var.vm_res.disk_type
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.example.id]
  }

  metadata = local.vm_metadata

  scheduling_policy {
    preemptible = true
  }

  depends_on = [
    yandex_compute_instance.db
  ]
}
