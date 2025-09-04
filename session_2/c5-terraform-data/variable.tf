variable "app_name" {
  type = string
  default = "nginx"
}

variable "app_revision" {
  type = string
  default = "1.0.0"
}

variable "vpc_name" {
  description = "Name of VPC"
  type = string
}

variable "vpc_cidr_block" {
  description = "CIDR Block for the VPC"
  type        = string
}

variable "availability_zones" {
  description = "List of availability zone"
  type        = list(string)
  default = ["a", "b", "c"]
}

variable "region" {
  default = "ap-northeast-2"
}