# locals {
#   subnet_list = [
#     { name = "subnet-public-apn2a",  cidr = "10.111.0.0/24", az = "ap-northeast-2a"},
#     { name = "subnet-public-apn2c",  cidr = "10.111.1.0/24", az = "ap-northeast-2c"},
#     { name = "subnet-private-apn2a", cidr = "10.111.2.0/24", az = "ap-northeast-2a"},
#     { name = "subnet-private-apn2c", cidr = "10.111.3.0/24", az = "ap-northeast-2c"}
#   ]
# }

# resource "aws_vpc" "this" {
#   cidr_block = "10.111.0.0/16"
# }

# resource "aws_subnet" "these" {
#   count = length(local.subnet_list)
  
#   vpc_id            = aws_vpc.this.id
#   cidr_block        = local.subnet_list[count.index].cidr
#   availability_zone = local.subnet_list[count.index].az
  
#   tags = {
#     Name = "local.subnet_list[count.index].name"
#   }
# }

# output "subnets" {
#   value = aws_subnet.these[*].cidr_block
# }