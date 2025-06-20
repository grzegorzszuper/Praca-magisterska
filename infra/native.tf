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


resource "aws_instance" "test_native" {
  ami                    = data.aws_ami.amazonlinux2.id
  instance_type          = var.instance_type
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name
 # user_data              = file("${path.module}/user_data_native.tpl")


  # --- Dodajemy połączenie przez SSM ---
  connection {
    type = "session_manager"
    host = self.id
  }

  provisioner "remote-exec" {
    inline = [
      # Instalacja potrzebnych narzędzi
      "sudo yum -y install python3 python3-pip git awscli amazon-ssm-agent",
      "sudo pip3 install numpy psutil",

      # Klon repo i uruchomienie benchmarku
      "git clone https://github.com/grzegorzszuper/Praca-magisterska.git /opt/repo",
      "cd /opt/repo/tests",
      "python3 benchmark.py --size 100 | sudo tee -a /var/log/matrix_native.log",
      "python3 benchmark.py --size 500 | sudo tee -a /var/log/matrix_native.log",
      "python3 benchmark.py --size 1000 | sudo tee -a /var/log/matrix_native.log",

      # Eksport do S3
      "sudo aws s3 cp /var/log/matrix_native.log s3://thesis-logs-dev/native/ --region eu-west-3",

      # (opcjonalnie) shutdown
      "sudo shutdown -h now",
    ]
  }

  tags = {
    Name    = "thesis-native"
    Variant = "native"
  }
}
