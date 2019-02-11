resource "aws_api_gateway_rest_api" "secure-api-gateway" {
  name        = "${var.name}"
  description = "${var.description}"
  body        = "${data.template_file.secure-api-gateway-swagger.rendered}"
}

data "template_file" "secure-api-gateway-swagger" {
  template = "${file("../../../Swagger/${var.service_name}/swagger.yaml")}"

  vars {
    get_lambda_arn = "${var.lambda_invoke_arn}"
  }
}

resource "aws_api_gateway_deployment" "secure-api-gateway-deployment" {
  rest_api_id = "${aws_api_gateway_rest_api.secure-api-gateway.id}"
  stage_name  = "default"
}