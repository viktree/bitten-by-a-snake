data "archive_file" "lambda_function" {
  type        = "zip"
  source_dir  = "../lambda"
  output_path = "lambda.zip"
}

data "aws_iam_policy_document" "lambda_function_policy" {
  statement {
    sid    = ""
    effect = "Allow"

    principals {
      identifiers = ["lambda.amazonaws.com"]
      type        = "Service"
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name               = "terraform_iam_for_lambda"
  assume_role_policy = "${data.aws_iam_policy_document.lambda_function_policy.json}"
}

resource "aws_lambda_function" "alexa_skill_lambda" {
  function_name    = "terraform_lambda_alexa"
  filename         = "${data.archive_file.lambda_function.output_path}"
  source_code_hash = "${data.archive_file.lambda_function.output_base64sha256}"
  role             = "${aws_iam_role.iam_for_lambda.arn}"
  handler          = "index.handler"
  runtime          = "nodejs8.10"

  environment {
    variables = {
      ALEXA_SKILL_ID = "${var.alexa_skill_id}"
    }
  }
}

output "aws_lambda_function_arn" {
  value = "${aws_lambda_function.alexa_skill_lambda.arn}"
}
