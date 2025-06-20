variable "aws_region" {
  type    = string
  default = "eu-west-3"
}

variable "env" {
  type    = string
  default = "dev"   # zmienisz na "prod" lub "test" w terraform.tfvars
}
