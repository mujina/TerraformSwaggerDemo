provider "aws" {
    region = "eu-west-1"
    profile = "pugme"
}

data "aws_vpc" "selected" {
  tags {
    Name = "Pugme"
  }
}

variable "audience" {}
variable "environment" {}
variable "created_by" {}
variable "s3_bucket" {}
variable "memory_size" {}
variable "service_name" {}

module "fidelity_demo_lambda" {
  source = "../tf_aws_lambda"
  name = "FidelityDemoLambda${var.environment}"
  s3_bucket = "${var.s3_bucket}"
  lambda_role_name = "FidelityDemoLambdaRole"
  description = "Terraform Provisioning of Lambda function with Swagger demo for ${var.environment}"
  vpc_id = "${data.aws_vpc.selected.id}"
  audience = "${var.audience}"
  created_by = "${var.created_by}"
  service_name = "FidelityDemo"
}

module "devops_demo_lambda" {
  source = "../tf_aws_lambda"
  name = "DevopsDemoLambda${var.environment}"
  s3_bucket = "${var.s3_bucket}"
  lambda_role_name = "DevopsDemoLambdaRole"
  description = "Terraform Provisioning of Lambda function with Swagger demo for ${var.environment}"
  vpc_id = "${data.aws_vpc.selected.id}"
  audience = "${var.audience}"
  created_by = "${var.created_by}"
  service_name = "DevopsDemo"
}

module "secure_de_api_gateway" {
  source = "../tf_aws_api_gateway"
  name = "SecureDEDemoAPIGateway${var.environment}"
  description = "Terraform Provisioning of API Gateway with Swagger demo for ${var.environment}"
  service_name = "${var.service_name}"
  environment = "${var.environment}"
}

module "fidelity_demo_lambda_permission" {
  source = "../tf_aws_lambda_permission"
  lambda_function_arn = "${module.fidelity_demo_lambda.lambda_arn}"
  source_arn = "${ module.secure_de_api_gateway.api_gateway_execution_arn}/*/*"
}

module "devops_demo_lambda_permission" {
  source = "../tf_aws_lambda_permission"
  lambda_function_arn = "${module.devops_demo_lambda.lambda_arn}"
  source_arn = "${ module.secure_de_api_gateway.api_gateway_execution_arn}/*/*"
}
