variable "alexa_skill_id" {}

resource "aws_lambda_permission" "default" {
  statement_id  = "AllowExecutionFromAlexa"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.alexa_skill_lambda.function_name}"
  principal     = "alexa-appkit.amazon.com"
}
