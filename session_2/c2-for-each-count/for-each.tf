locals {
  subnet2_list = [
    { name = "subnet-public-apn2a",  cidr = "10.111.0.0/24", az = "ap-northeast-2a"},
    { name = "subnet-public-apn2c",  cidr = "10.111.1.0/24", az = "ap-northeast-2c"},
    { name = "subnet-private-apn2a", cidr = "10.111.2.0/24", az = "ap-northeast-2a"},
    { name = "subnet-private-apn2c", cidr = "10.111.3.0/24", az = "ap-northeast-2c"}
  ]
}

# 예상 출력
# ---------------------------------------------------------------
# Apply complete! Resources: 5 added, 0 changed, 0 destroyed.

# Outputs:

# subnets = {
#   "subnet_private_apn2a" = "10.111.2.0/24"
#   "subnet_private_apn2c" = "10.111.3.0/24"
#   "subnet_public_apn2a" = "10.111.0.0/24"
#   "subnet_public_apn2c" = "10.111.1.0/24"
# }
# ---------------------------------------------------------------