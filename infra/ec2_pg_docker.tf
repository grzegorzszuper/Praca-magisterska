resource "aws_instance" "pg_docker" {
  ami                    = data.aws_ami.centos7.id
  instance_type          = var.instance_type
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name
  key_name               = aws_key_pair.thesis_key.key_name
  vpc_security_group_ids = [aws_security_group.thesis_sg.id]
  availability_zone      = "eu-west-3a"

  tags = {
    Name = "postgres-docker"
    Type = "db-test"
  }
}
