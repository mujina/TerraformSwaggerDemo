variable "name" {
  description = "(Required) A unique name for the Lambda function."
}

variable "description" {
  description = "(Optional) Description of what your Lambda Function does."
  default = ""
}

variable "service_name" {
  description = "(Required) Unique service name for the Lambda function"
}

variable "created_by" {
  description = "(Optional) Name of person who created the resource"
}

variable "vpc_id" {
  description = "VPC ID for Lambda"
}

variable "audience"  {
  description = "Fidelity type environment"
}

variable "handler" {
  description = "(Required) The function entrypoint in your code."
  default = "index.handler"
}

variable "s3_bucket" {
  description = "(Required) Name of S3 bucket that contains package"
}

variable "package_name" {
  description = "(Required) Name of the package object in S3"
  default = "package-latest.zip"
}

variable "lambda_role_name" {
  description  = "(Required) Name of the Lambda role"
}

variable "memory_size" {
  description = "(Optional) Memory size of Lambda"
  default = "128"
}