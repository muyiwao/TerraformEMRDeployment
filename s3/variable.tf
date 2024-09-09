variable "log_retention_days" {
  description = "Number of days to retain log files in the S3 bucket"
  type        = number
  default     = 90
}

variable "script_retention_days" {
  description = "Number of days to retain script files in the S3 bucket"
  type        = number
  default     = 90
}
