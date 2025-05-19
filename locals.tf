locals {
  aws_account_id = data.aws_caller_identity.current.account_id

  ecr_image_uri = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.aws_region}.amazonaws.com/${var.aws_region}-${var.environment}-ecr:latest"
}
