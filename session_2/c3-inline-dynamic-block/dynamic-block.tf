# # VPC 생성
# resource "aws_vpc" "this" {
#   cidr_block = "10.0.0.0/16"
#   enable_dns_hostnames = true
# }

# locals {
#   sg_rules_this = {
#     ingress = [
#       { from_port = 80, to_port = 80, protocol = "tcp", cidr_blocks = "0.0.0.0/0" },
#       { from_port = 443, to_port = 443, protocol = "tcp", cidr_blocks = "0.0.0.0/0" },
#       { from_port = 22, to_port = 22, protocol = "tcp", cidr_blocks = "0.0.0.0/0" }
#     ]
#     egress = [
#       { from_port = 0, to_port = 0, protocol = -1, cidr_blocks = "0.0.0.0/0" }
#     ]
#   }
# }

# # 보안그룹 생성
# resource "aws_security_group" "this" {
#   name        = "sgs-c3-inline-block"
#   description = "Security group for testing inline-block"
#   vpc_id      = aws_vpc.this.id

#   dynamic "ingress" {
#     for_each = ########
#     content {
#       ########
#     }
#   }

#   dynamic "egress" {
#     for_each = ######## 
#     content {
#       ########
#     }
#   }
# }

# # 출력
# output "sg_this_ingress" {
#   value = aws_security_group.this.ingress
# }

# output "sg_this_egress" {
#   value = aws_security_group.this.egress
# }