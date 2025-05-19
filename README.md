# Lambda

* Lambda runs your code on a high-availability compute infrastructure and performs all of the administration of the compute resources, including server and operating system maintenance, capacity provisioning and automatic scaling, and logging. With Lambda, all you need to do is supply your code in one of the language runtimes that Lambda supports.

* Lambda is an ideal compute service for application scenarios that need to scale up rapidly, and scale down to zero when not in demand.

## Additional Resources

- [Amazon Lambda User Guide](https://docs.aws.amazon.com/lambda/latest/dg/welcome.html)
- [Terraform AWS Lambda Module Documentation](https://registry.terraform.io/modules/terraform-aws-modules/lambda/aws/latest)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.98.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_image_lambda"></a> [image\_lambda](#module\_image\_lambda) | terraform-aws-modules/lambda/aws | 7.21.0 |
| <a name="module_python_lambda"></a> [python\_lambda](#module\_python\_lambda) | terraform-aws-modules/lambda/aws | 7.21.0 |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_event_rule.python_lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.python_lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_iam_policy.lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_lambda_permission.python_lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_lambda_permission.s3_invoke_lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_sns_topic.python_lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |
| [aws_sns_topic_subscription.python_lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_security_group.private_nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/security_group) | data source |
| [aws_subnets.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [aws_vpc.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app\_id](#input\_app\_id) | A unique identifier for your application, used in provisioning profiles. | `string` | n/a | yes |
| <a name="input_architecture_type"></a> [architecture\_type](#input\_architecture\_type) | List of architectures for the Lambda function. Valid values are 'x86\_64' and 'arm64'. | `list(string)` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The AWS region where resources will be created (e.g., us-east-1, us-west-2). | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The name of the environment where resources will be deployed (e.g., dev, staging, prod). | `string` | n/a | yes |
| <a name="input_mail"></a> [mail](#input\_mail) | provide an email to send mails | `list(string)` | n/a | yes |
| <a name="input_memory_size"></a> [memory\_size](#input\_memory\_size) | provide the memory size, default is 128 MB | `number` | n/a | yes |
| <a name="input_retention_in_days"></a> [retention\_in\_days](#input\_retention\_in\_days) | retention no of days, default is 7 days | `number` | n/a | yes |
| <a name="input_runtime"></a> [runtime](#input\_runtime) | python run time for example python3.13 | `string` | n/a | yes |
| <a name="input_schedule_expression"></a> [schedule\_expression](#input\_schedule\_expression) | The schedule expression for the event | `string` | n/a | yes |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | python timeout, default is 300 seconds | `number` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_security_group_id"></a> [aws\_security\_group\_id](#output\_aws\_security\_group\_id) | n/a |
| <a name="output_image_lambda_name"></a> [image\_lambda\_name](#output\_image\_lambda\_name) | n/a |
| <a name="output_pocicy_name"></a> [pocicy\_name](#output\_pocicy\_name) | n/a |
| <a name="output_private_subnets"></a> [private\_subnets](#output\_private\_subnets) | n/a |
| <a name="output_python_lambda_name"></a> [python\_lambda\_name](#output\_python\_lambda\_name) | n/a |
| <a name="output_role_name"></a> [role\_name](#output\_role\_name) | n/a |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | n/a |
<!-- END_TF_DOCS -->
