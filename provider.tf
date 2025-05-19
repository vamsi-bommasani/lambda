provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      region              = var.aws_region
      app-id              = var.app_id
      environmentironment = var.environment
    }
  }
}
