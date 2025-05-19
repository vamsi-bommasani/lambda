# ======================================================
# AWS
# ======================================================

variable "aws_region" {
  description = "The AWS region where resources will be created (e.g., us-east-1, us-west-2)."
  type        = string
}

# ======================================================
# Tags
# ======================================================

variable "app_id" {
  description = "A unique identifier for your application, used in provisioning profiles."
  type        = string
}

variable "environment" {
  description = "The name of the environment where resources will be deployed (e.g., dev, staging, prod)."
  type        = string
}

# ======================================================
# Default Lambda Variables
# ======================================================

variable "memory_size" {
  description = "provide the memory size, default is 128 MB"
  type        = number
}

variable "timeout" {
  description = "python timeout, default is 300 seconds"
  type        = number
}

variable "retention_in_days" {
  description = "retention no of days, default is 7 days"
  type        = number
}

# ======================================================
# Image Based Lambda
# ======================================================

variable "architecture_type" {
  description = "List of architectures for the Lambda function. Valid values are 'x86_64' and 'arm64'."
  type        = list(string)
}

# ======================================================
# Python Based Lambda
# ======================================================

variable "runtime" {
  description = "python run time for example python3.13"
  type        = string
}

variable "mail" {
  description = "provide an email to send mails"
  type        = list(string)
}

variable "schedule_expression" {
  description = "The schedule expression for the event"
  type        = string
}
