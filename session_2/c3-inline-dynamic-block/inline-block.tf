# VPC 생성
resource "aws_vpc" "this" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
}

# 보안그룹 생성
resource "aws_security_group" "this" {
  name        = "sgs-c3-inline-block"
  description = "Security group for testing inline-block"
  vpc_id      = aws_vpc.this.id

  # HTTP 인바운드 규칙
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTPS 인바운드 규칙
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # SSH 인바운드 규칙
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # 실제 환경에서는 특정 IP로 제한 권장
  }

  # 모든 아웃바운드 트래픽 허용
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 출력
output "sg_this_ingress" {
  value = aws_security_group.this.ingress
}

output "sg_this_egress" {
  value = aws_security_group.this.egress
}