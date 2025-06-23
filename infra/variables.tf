variable "aws_region" {
  type    = string
  default = "eu-west-3"
}

variable "env" {
  type    = string
  default = "dev"   # zmienisz na "prod" lub "test" w terraform.tfvars
}

variable "instance_type" {
  description = "Typ instancji EC2"
  type        = string
  default     = "c7i.large"
}

variable "ssh_public_key_path" {
  type        = string
  description = "Ścieżka do pliku .pub dla klucza SSH"
}

variable "my_ip_cidr" {
  type        = string
}
