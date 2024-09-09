variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "subnet_cidr_block" {
  description = "CIDR block for the subnet"
  default     = "10.0.1.0/24"
}

variable "availability_zone" {
  description = "Availability Zone for the subnet"
  type        = string
}
