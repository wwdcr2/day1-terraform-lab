locals {
  instance_placement_subnet_id = aws_subnet.publics[local.instance_placement_az].id
}

# Revision Control
resource "terraform_data" "sample_app_revision" {
  input = var.app_revision
}

resource "aws_instance" "sample_app" {
  ami = data.aws_ami.al2023.id

  associate_public_ip_address = true
  subnet_id                   = local.instance_placement_subnet_id
  instance_type               = "t3.micro"
  key_name                    = aws_key_pair.demo.key_name
  vpc_security_group_ids      = [aws_security_group.ec2.id]

  tags = {
    "Name" = var.app_name
  }

  connection {
    type     = "ssh"
    host     = aws_instance.sample_app.public_ip
    user     = "ec2-user"
    private_key = file("./${local_file.demo.filename}")
  }

  provisioner "file" {
    source      = "./sample-app/app-init.sh"  # install-nginx.sh
    destination = "./app-init.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo cp -rf /tmp/default.conf /etc/nginx/conf.d/default.conf",
      "sudo chmod +x ./app-init.sh",
      "sudo ./app-init.sh",
<<EOF
echo heredock working
echo hello world
EOF
    ]
  }
}

# Provisioning App
resource "terraform_data" "sample_app_deploy" {
  triggers_replace = [
    aws_instance.sample_app.public_ip,
    terraform_data.sample_app_revision.output
  ]

  connection {
    type     = "ssh"
    host     = aws_instance.sample_app.public_ip
    user     = "ec2-user"
    private_key = file("./${local_file.demo.filename}")
  }

  provisioner "file" {
    source      = "./sample-app/${terraform_data.sample_app_revision.output}"
    destination = "/tmp/${terraform_data.sample_app_revision.output}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo cp -rf /tmp/${terraform_data.sample_app_revision.output} /usr/share/nginx/html/index.html",
      "sudo systemctl restart nginx"
    ]
  }
}

output "app_url" {
  value = "http://${aws_instance.sample_app.public_ip}"
}
