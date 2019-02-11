output "lambda_arn" {
  value = "${aws_lambda_function.lambda_function.arn}"
}

output "lambda_invoke_arn" {
  # The ARN to be used for invoking Lambda funtions from API Gateway
  value = "${aws_lambda_function.lambda_function.invoke_arn}"
}
