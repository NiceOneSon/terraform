locals {
  creds      = split("\n", file("./secrets.txt"))
  username_line    = element(local.creds, 0)
  password_line  = element(local.creds, 1)

  username   = regex("\"([^\"]+)\"", local.username_line)[0]
  password = regex("\"([^\"]+)\"", local.password_line)[0]
}
