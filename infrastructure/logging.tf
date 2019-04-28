resource "aws_cloudwatch_log_group" "logging_group" {
  name              = "${aws_lambda_function.alexa_skill_lambda.function_name}"
  retention_in_days = 14
}

data "aws_iam_policy_document" "lambda_logging_policy" {
  statement {
    effect    = "Allow"
    resources = ["arn:aws:logs:*:*:*"]

    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
  }
}

# See also the following AWS managed policy: AWSLambdaBasicExecutionRole
resource "aws_iam_policy" "lambda_logging" {
  name        = "terraform_lambda_logging"
  path        = "/"
  description = "IAM policy for logging from a lambda"

  policy = "${data.aws_iam_policy_document.lambda_logging_policy.json}"
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = "${aws_iam_role.iam_for_lambda.name}"
  policy_arn = "${aws_iam_policy.lambda_logging.arn}"
}
