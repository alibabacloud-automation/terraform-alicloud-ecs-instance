terraform {
  backend "local" {}
}

output "test" {
  value = "Hello, World"
}
