# infra/ec2_docker.tf

resource "aws_instance" "test_docker" {
  ami                    = data.aws_ami.amazonlinux2.id
  instance_type          = var.instance_type
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name
  key_name               = aws_key_pair.generated_key.key_name
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.instance_sg.id]

  tags = {
    Name = "thesis-docker-${var.env}"
  }

  lifecycle {
    create_before_destroy = true
  }
}

output "docker_instance_ip" {
  value = aws_instance.test_docker.public_ip
}
