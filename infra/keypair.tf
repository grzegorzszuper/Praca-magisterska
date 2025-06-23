resource "aws_key_pair" "thesis_key" {
  key_name   = "thesis-key"
  public_key = file(var.ssh_public_key_path)

  tags = {
    Name = "thesis-key"
  }
}
