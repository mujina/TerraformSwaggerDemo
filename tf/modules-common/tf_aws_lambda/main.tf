module "iam_lambda" {
  source = "../tf_aws_iam_lambda"
  lambda_role_name = "${var.lambda_role_name}"
}

resource "aws_lambda_function" "lambda_function" {
  function_name = "${var.name}"
  description = "${var.description}"

  # The bucket name as created earlier with "aws s3api create-bucket"
  s3_bucket = "${var.s3_bucket}"
  s3_key = "${var.service_name}/${var.package_name}"

  # "main" is the filename within the zip file (index.js) and "handler"
  # is the name of the property under which the handler function was
  # exported in that file.
  handler = "${var.handler}"
  runtime = "python3.6"
  memory_size = "${var.memory_size}"

  role = "${module.iam_lambda.lambda_arn}"
}