resource "aws_api_gateway_rest_api" "secure-api-gateway" {
  name        = "${var.name}"
  description = "${var.description}"
  body        = "${data.template_file.secure-api-gateway-swagger.rendered}"
}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "template_file" "secure-api-gateway-swagger" {
  template = "${file("../../../Swagger/swagger-merged.yaml")}"

  vars {
    aws_region = "${data.aws_region.current.name}",
    environment = "${var.environment}",
    account_id = "${data.aws_caller_identity.current.account_id}",
  }
}

resource "aws_api_gateway_deployment" "secure-api-gateway-deployment" {
  rest_api_id = "${aws_api_gateway_rest_api.secure-api-gateway.id}"
  stage_name  = "default"
}