# infra/native.tf

# 1. Pobranie najnowszego Amazon Linux 2 AMI
data "aws_ami" "amazonlinux2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# 2. Pobranie domyślnego VPC (jeśli chcesz użyć default VPC)
data "aws_vpc" "default" {
  default = true
}

# 3. Pobranie domyślnego subnetu (dla default VPC)
data "aws_subnet" "default" {
  default_for_az = true
  availability_zone = "eu-west-3a"   # Dostosuj jeśli chcesz
}

# 4. EC2 instance
resource "aws_instance" "test_native" {
  ami                    = data.aws_ami.amazonlinux2.id
  instance_type          = var.instance_type
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name
  key_name               = aws_key_pair.thesis_key.key_name
  vpc_security_group_ids  = [aws_security_group.thesis_sg.id]
  subnet_id              = data.aws_subnet.default.id

  tags = {
    Name = "thesis-native-${var.env}"
  }
}

