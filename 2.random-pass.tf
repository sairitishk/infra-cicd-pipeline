resource "random_password" "pass1" {
  count       = 3
  length      = 12
  special     = true
  min_lower   = 3
  min_numeric = 3
  min_special = 3
  min_upper   = 3
}