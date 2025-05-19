# ======================================================
# IAM
# ======================================================

resource "aws_iam_role" "lambda" {
  name = "${var.aws_region}-${var.environment}-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = [
          "lambda.amazonaws.com",
          "events.amazonaws.com"
        ]
      }
    }]
  })
}

resource "aws_iam_policy" "lambda" {
  name = "${var.aws_region}-${var.environment}-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "lambda:InvokeFunction"
        ]
        Effect   = "Allow"
        Resource = "arn:aws:lambda:${var.aws_region}:${local.aws_account_id}:function:*"
      },
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Effect   = "Allow"
        Resource = "arn:aws:logs:${var.aws_region}:${local.aws_account_id}:log-group:*"
      },
      {
        Action = [
          "sns:Publish"
        ]
        Effect   = "Allow"
        Resource = "arn:aws:sns:${var.aws_region}:${local.aws_account_id}:*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda" {
  role       = aws_iam_role.lambda.name
  policy_arn = aws_iam_policy.lambda.arn
}

# ======================================================
# Image based ECR Lambda triggered with S3
# ======================================================

module "image_lambda" {
  source                            = "terraform-aws-modules/lambda/aws"
  version                           = "7.21.0"
  function_name                     = "${var.aws_region}-${var.environment}-image-lambda"
  description                       = "Image setup Lambda function"
  lambda_role                       = aws_iam_role.lambda.arn
  memory_size                       = var.memory_size
  package_type                      = "Image"
  image_uri                         = local.ecr_image_uri
  architectures                     = var.architecture_type
  timeout                           = var.timeout
  cloudwatch_logs_retention_in_days = var.retention_in_days
  create_package                    = false
  vpc_subnet_ids                    = data.aws_subnets.private.ids
  vpc_security_group_ids            = data.aws_security_group.private_nat.id
  environment_variables = {
    S3_BUCKET_NAME = "${var.aws_region}-${var.environment}-s3"
  }
}

resource "aws_lambda_permission" "s3_invoke_lambda" {
  statement_id  = "AllowS3Invoke"
  action        = "lambda:InvokeFunction"
  function_name = module.image_lambda.lambda_function_name
  principal     = "s3.amazonaws.com"
  source_arn    = "arn:aws:s3:::${var.aws_region}-${var.environment}-s3"
}

# ======================================================
# Python based Lambda triggered with timmer
# ======================================================

module "python_lambda" {
  source                            = "terraform-aws-modules/lambda/aws"
  version                           = "7.21.0"
  function_name                     = "${var.aws_region}-${var.environment}-python-lambda"
  description                       = "Python setup Lambda function"
  lambda_role                       = aws_iam_role.lambda.arn
  memory_size                       = var.memory_size
  runtime                           = var.runtime
  handler                           = "hello_world.main"
  timeout                           = var.timeout
  source_path                       = "src/hello_world.py"
  cloudwatch_logs_retention_in_days = var.retention_in_days
  environment_variables = {
    SNS_TOPIC_ARN = aws_sns_topic.python_lambda.arn
  }
}

resource "aws_cloudwatch_event_rule" "python_lambda" {
  name                = "${var.aws_region}-${var.environment}-cloudwatchevent-rule"
  description         = "Triggers Lambda based on the provided schedule"
  schedule_expression = var.schedule_expression
}

resource "aws_cloudwatch_event_target" "python_lambda" {
  rule      = aws_cloudwatch_event_rule.python_lambda.name
  target_id = "lambda_cloudwatch_event_target"
  arn       = module.python_lambda.lambda_function_arn
}

resource "aws_lambda_permission" "python_lambda" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = module.python_lambda.lambda_function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.python_lambda.arn
}

resource "aws_sns_topic" "python_lambda" {
  name = "${var.aws_region}-${var.environment}-sns-topic"
}

resource "aws_sns_topic_subscription" "python_lambda" {
  count     = length(var.mail)
  topic_arn = aws_sns_topic.python_lambda.arn
  protocol  = "email"
  endpoint  = var.mail[count.index]
}
