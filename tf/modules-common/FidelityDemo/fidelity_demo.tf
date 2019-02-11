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
  name = "${var.service_name}Lambda${var.environment}"
  s3_bucket = "${var.s3_bucket}"
  lambda_role_name = "${var.service_name}LambdaRole"
  description = "Terraform Provisioning of Lambda function with Swagger demo for ${var.environment}"
  vpc_id = "${data.aws_vpc.selected.id}"
  audience = "${var.audience}"
  created_by = "${var.created_by}"
  memory_size = "${var.memory_size}"
}

module "fidelity_demo_api_gateway" {
  source = "../tf_aws_api_gateway"
  name = "${var.service_name}APIGateway${var.environment}"
  description = "Terraform Provisioning of API Gateway with Swagger demo for ${var.environment}"
  service_name = "${var.service_name}"
  lambda_invoke_arn = "${module.fidelity_demo_lambda.lambda_invoke_arn}"
}

module "fidelity_demo_lambda_permission" {
  source = "../tf_aws_lambda_permission"
  lambda_function_arn = "${module.fidelity_demo_lambda.lambda_arn}"
  source_arn = "${ module.fidelity_demo_api_gateway.api_gateway_execution_arn}/*/*"
}