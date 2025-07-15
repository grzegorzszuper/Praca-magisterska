resource "aws_instance" "io_native" {
  ami                         = data.aws_ami.amazonlinux2_io.id
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.thesis_key.key_name
  iam_instance_profile        = aws_iam_instance_profile.ec2_profile.name
  vpc_security_group_ids      = [aws_security_group.thesis_sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "io-native"
    Env  = var.env
  }
}

resource "aws_instance" "io_docker" {
  ami                         = data.aws_ami.amazonlinux2_io.id
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.thesis_key.key_name
  iam_instance_profile        = aws_iam_instance_profile.ec2_profile.name
  vpc_security_group_ids      = [aws_security_group.thesis_sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "io-docker"
    Env  = var.env
  }
}
