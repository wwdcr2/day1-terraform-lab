##############################################################################
# Variables File
#
# Here is where we store the default values for all the variables used in our
# Terraform code. If you create a variable with no default, the user will be
# prompted to enter it (or define it via config file or command line flags.)

variable "prefix" {
  description = "This prefix will be included in the name of most resources."
  type        = string
  default     = "academy"
}

variable "region" {
  description = "The region where the resources are created."
  type        = string
  default     = "us-east-1"
}

variable "address_space" {
  description = "The address space that is used by the virtual network. You can supply more than one address space. Changing this forces a new resource to be created."
  type        = string
  default     = "10.0.0.0/16"
  validation {
    condition     = can(cidrhost(var.string_like_valid_ipv4_cidr, 32), var.address_space)
    error_message = "variable address_space must be valid IPv4 CIDR."
  }
}

variable "subnet_prefix" {
  description = "The address prefix to use for the subnet."
  type        = string
  default     = "10.0.10.0/24"
}

variable "instance_type" {
  description = "Specifies the AWS instance type."
  type        = string
  default     = "t2.micro"
}

variable "admin_username" {
  description = "Administrator user name for mysql"
  type        = string
  default     = "hashicorp"
}

variable "height" {
  default     = 400
  type        = number
  description = "Image height in pixels."
}

variable "width" {
  default     = 600
  type        = number
  description = "Image width in pixels."
}

variable "placeholder" {
  default     = "placecats.com/millie_neo"
  type        = string
  description = "Image-as-a-service URL. Some other fun ones to try are fillmurray.com, placecage.com, placebeard.it, loremflickr.com, baconmockup.com, placeimg.com, placebear.com, placeskull.com, stevensegallery.com, placedog.net"
}