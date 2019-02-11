output "url" {
  value = "${aws_api_gateway_deployment.secure-api-gateway-deployment.invoke_url}/api"
}

output "api_gateway_execution_arn" {
  value = "${aws_api_gateway_deployment.secure-api-gateway-deployment.execution_arn}"
}