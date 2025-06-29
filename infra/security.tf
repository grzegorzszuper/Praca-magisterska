# Security Group dla SSH dostępu do EC2

data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "thesis_sg" {
  name        = "thesis-sg"
  description = "Security group for SSH access to thesis EC2"
  vpc_id      = data.aws_vpc.default.id


  ingress {
    description = "SSH from my IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip_cidr]  # podasz swoje IP w zmiennej
  }

  ingress {
    description = "HTTP access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "thesis-sg"
  }
}

