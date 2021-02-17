provider "lacework" {}

provider "aws" {}

module "aws_config" {
  source = "lacework/config/aws"
}
