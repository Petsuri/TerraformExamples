variable "mysql_config" {
  description = "The config for the MySQL database"
  type = object({
    address = string
    port    = number
  })

  default = {
    address = "mock-mysql-address"
    port    = 12345
  }
}
