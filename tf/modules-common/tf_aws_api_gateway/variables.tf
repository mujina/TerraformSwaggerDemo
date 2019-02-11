variable "service_name" {
    description = "(Required) Service Name for API Gateway e.g. FidelityDemo"
}

variable "name" {
  description = "(Required) Name of the API gateway"
}

variable "description" {
  description = "(Optional) Description of API gateway"
}

variable "lambda_invoke_arn" {
  description = "(Required) ARN of Lambda to associate with gateway"
}