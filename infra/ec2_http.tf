resource "aws_instance" "http_native" {
  ami                    = "ami-0df6cfabfbe438a58"
  instance_type          = var.instance_type
  key_name               = aws_key_pair.thesis_key.key_name
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name

  vpc_security_group_ids = [aws_security_group.thesis_sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "http-native"
    Env  = var.env
  }
}

resource "aws_instance" "http_docker" {
  ami                    = "ami-0df6cfabfbe438a58"
  instance_type          = var.instance_type
  key_name               = aws_key_pair.thesis_key.key_name
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name

  vpc_security_group_ids = [aws_security_group.thesis_sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "http-docker"
    Env  = var.env
  }
}

resource "aws_instance" "http_client" {
  ami                    = "ami-0df6cfabfbe438a58"
  instance_type          = var.instance_type
  key_name               = aws_key_pair.thesis_key.key_name
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name

  vpc_security_group_ids = [aws_security_group.thesis_sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "http-client"
    Env  = var.env
  }
}
