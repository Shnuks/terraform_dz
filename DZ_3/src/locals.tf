locals {
  ssh_public_key = file(pathexpand("~/.ssh/id_rsa.pub"))

  vm_metadata = {
    ssh-keys = "${var.vm_ssh_user}:${local.ssh_public_key}"
  }
}
