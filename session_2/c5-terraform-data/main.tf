locals {
  resource_name = "demo"
}

data "aws_ami" "al2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Create Key Pair
resource "tls_private_key" "demo" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "demo" {
  key_name   = local.resource_name
  public_key = tls_private_key.demo.public_key_openssh
}

resource "local_file" "demo" {
  filename        = "${aws_key_pair.demo.key_name}.pem"
  content         = tls_private_key.demo.private_key_pem
  file_permission = "0400"
}

resource "terraform_data" "delete_local_key_pair" {
  input = aws_key_pair.demo

  provisioner "local-exec" {
    when    = destroy
    command = "rm -f ./${self.input.key_name}.pem"
  }
}
