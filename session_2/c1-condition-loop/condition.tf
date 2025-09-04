resource "aws_vpc" "this" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
}

output "condition" {
  value = aws_vpc.this.enable_dns_hostnames ? "${aws_vpc.this.id}의 dns hostname 활성화 됨" : "${aws_vpc.this.id}의 dns hostname 비활성화 됨"
}