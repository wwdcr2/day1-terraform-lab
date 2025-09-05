# resource "aws_instance" "implicit_exmaple_a" {
#   ami                         = data.aws_ami.ubuntu.id
#   instance_type               = var.instance_type
#   associate_public_ip_address = true
#   subnet_id                   = aws_subnet.hashicat.id
#   vpc_security_group_ids      = [aws_security_group.hashicat.id]

#   depends_on = [aws_instance.implicit_exmaple_b]
# }

# resource "aws_instance" "implicit_exmaple_b" {
#   ami                         = data.aws_ami.ubuntu.id
#   instance_type               = var.instance_type
#   associate_public_ip_address = true
#   subnet_id                   = aws_subnet.hashicat.id
#   vpc_security_group_ids      = [aws_security_group.hashicat.id]
# }
