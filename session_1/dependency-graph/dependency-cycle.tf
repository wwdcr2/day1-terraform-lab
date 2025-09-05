# resource "aws_instance" "dependency_cycle" {
#   ami                         = data.aws_ami.ubuntu.id
#   instance_type               = var.instance_type
#   associate_public_ip_address = true
#   subnet_id                   = aws_subnet.hashicat.id
#   vpc_security_group_ids      = [aws_security_group.hashicat.id]

#   depends_on = [aws_volume_attachment.dependency_cycle_attachment]
# }

# resource "aws_ebs_volume" "dependency_cycle" {
#   availability_zone = aws_instance.dependency_cycle.availability_zone
#   size              = 1

#   depends_on = [aws_instance.dependency_cycle]
# }

# resource "aws_volume_attachment" "dependency_cycle_attachment" {
#   device_name = "/dev/xvdf"
#   instance_id = aws_instance.dependency_cycle.id
#   volume_id   = aws_ebs_volume.dependency_cycle.id

#   depends_on = [aws_ebs_volume.dependency_cycle, aws_instance.dependency_cycle]
# }
