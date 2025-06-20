# infra/ec2_native.tf

# 1. Pobieramy najnowszy Amazon Linux 2 AMI
data "aws_ami" "amazonlinux2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# 2. Definicja instancji EC2 dla testu native
resource "aws_instance" "test_native" {
  ami                    = data.aws_ami.amazonlinux2.id
  instance_type          = var.instance_type
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name
  user_data              = file("${path.module}/user_data_native.tpl")
  tags = {
    Name    = "thesis-native"
    Variant = "native"
  }
}
