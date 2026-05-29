locals {
  vm_names = {
    web = "${var.project_prefix}-${var.environment}-web"
    db  = "${var.project_prefix}-${var.environment}-db"
  }
}
