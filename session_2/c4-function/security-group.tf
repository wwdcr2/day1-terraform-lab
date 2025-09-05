locals {
  security_group_list = [
    { name = "sgs-web", description = "Security group for web" },
    { name = "sgs-db", description = "Security group for db" }
  ]

  sg_name_rule_list = "?????"
  # example
  # tolist([
  #   {
  #     "cidr_blocks" = "0.0.0.0/0"
  #     "description" = "http from internet"
  #     "from_port" = "80"
  #     "protocol" = "tcp"
  #     "security_group_name" = "sgs-web"
  #     "to_port" = "80"
  #     "type" = "ingress"
  #   },
  #   {
  #   }...
  # ])

  # After data block
  sg_id_rule_map = "?????"
}

# Security Group Name으로 Security Group ID 조회
data "aws_security_group" "these" {
  for_each = toset([for rule in local.sg_name_rule_list : rule.security_group_name])

  filter {
    name   = "tag:Name"
    values = [each.value]
  }

  vpc_id = aws_vpc.this.id

  depends_on = [aws_security_group.these]
}


resource "aws_vpc" "this" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
}

resource "aws_security_group" "these" {
  for_each = {
    for k, v in local.security_group_list : v.name => v
  }

  name        = each.value.name
  description = each.value.description
  vpc_id      = aws_vpc.this.id

  tags = {
    Name = each.value.name
  }
}

resource "aws_security_group_rule" "these" {
  for_each = local.sg_id_rule_map

  security_group_id = each.value.security_group_id
  type              = each.value.type
  protocol          = each.value.protocol
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  cidr_blocks       = [each.value.cidr_blocks]
  description       = each.value.description
}

output "convert_1_sg_name_rule_list" {
  value = local.sg_name_rule_list
}

output "convert_2_aws_security_group" {
  value = data.aws_security_group.these
}

output "convert_3_sg_id_rule_map" {
  value = local.sg_id_rule_map
}