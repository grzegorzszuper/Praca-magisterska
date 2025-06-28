# infra/native.tf

# 2. Pobranie domyślnego VPC (jeśli chcesz użyć default VPC)
data "aws_vpc" "default" {
  default = true
}

# 3. Pobranie domyślnego subnetu (dla default VPC)
data "aws_subnet" "default" {
  default_for_az = true
  availability_zone = "eu-west-3a"   # Dostosuj jeśli chcesz
}


resource "aws_instance" "pg_native" {
  ami                         = data.aws_ami.amazonlinux2.id
  instance_type               = var.instance_type
  iam_instance_profile        = aws_iam_instance_profile.ec2_profile.name
  key_name                    = aws_key_pair.thesis_key.key_name
  vpc_security_group_ids      = [aws_security_group.thesis_sg.id]
  availability_zone           = "eu-west-3a"

  tags = {
    Name = "postgres-native"
    Type = "db-test"
  }
}



