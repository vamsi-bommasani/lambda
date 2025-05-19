output "role_name" {
  value = aws_iam_role.lambda.name
}

output "pocicy_name" {
  value = aws_iam_policy.lambda.name
}

output "image_lambda_name" {
  value = module.image_lambda.lambda_function_name
}

output "python_lambda_name" {
  value = module.python_lambda.lambda_function_name
}

output "vpc_id" {
  value = data.aws_vpc.vpc.id
}

output "private_subnets" {
  value = data.aws_subnets.private.ids
}

output "aws_security_group_id" {
  value = data.aws_security_group.private_nat.id
}
