// Global variable definitions that might be required by multiple modules

// Availability zone used by network module to place resources
variable "availability_zone" {
  description = "Availability Zone to deploy resources in"
  type        = string
  default     = "eu-west-2a"
}

// Tags are useful for resource identification and management especially in cost analysis.
variable "global_tags" {
  description = "Global tags to be applied to all resources."
  type        = map(string)
  default = {
    Terraform   = "true"
    Environment = "development"
  }
}

// Optionally, you might also include network CIDR defaults here if they are not likely to change often

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "subnet_cidr_block" {
  description = "The CIDR block for the subnet within the VPC"
  default     = "10.0.1.0/24"
}
