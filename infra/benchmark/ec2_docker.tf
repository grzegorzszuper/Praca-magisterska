# infra/ec2_docker.tf

resource "aws_instance" "test_docker" {
  ami                    = data.aws_ami.amazonlinux2.id
  instance_type          = var.instance_type
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name
  key_name               = aws_key_pair.thesis_key.key_name        # Poprawka
  vpc_security_group_ids = [aws_security_group.thesis_sg.id]       # Poprawka
  subnet_id              = data.aws_subnet.default.id              # Dodaj jak w native.tf

  tags = {
   Name = "thesis-docker-${var.env}"
  }
}


output "docker_instance_ip" {
  value = aws_instance.test_docker.public_ip
}
