variable "app_name" {
  type    = string
  default = "nginx"
}

variable "app_revision" {
  type    = string
  default = "1.0.0"
}

variable "vpc_cidr_block" {
  description = "CIDR Block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "List of availability zone"
  type        = list(string)
  default     = ["a", "b", "c"]
}

variable "region" {
  default = "ap-northeast-2"
}