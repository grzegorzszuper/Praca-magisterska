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

# 4. EC2 instance postgres
resource "aws_instance" "pg_native" {
  ami = "ami-07d35a33c3c4cba9c"  # CentOS 7 (x86_64) - GenericCloud-2404
  instance_type          = var.instance_type
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name
  key_name               = aws_key_pair.thesis_key.key_name
  vpc_security_group_ids = [aws_security_group.thesis_sg.id]
  availability_zone      = "eu-west-3a"

  tags = {
    Name = "postgres-native"
    Type = "db-test"
  }
}


