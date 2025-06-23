output "ec2_public_ip" {
  value = aws_instance.test_native.public_ip
}
