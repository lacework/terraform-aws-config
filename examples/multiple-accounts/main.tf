# Configures a compliance integration of the AWS account-1 to
# the Lacework sub-account account-1
module "aws_config_account-1" {
  source = "../../"

  providers = {
    lacework = lacework.account-1
    aws      = aws.account-1
  }

  lacework_integration_name = "account-1"
}

# Configures a compliance integration of the AWS account-2 to
# the Lacework sub-account account-2
module "aws_config_account-2" {
  source = "../../"

  providers = {
    lacework = lacework.account-2
    aws      = aws.account-2
  }

  lacework_integration_name = "account-2"
}

# Configures a compliance integration of the AWS account-3 to
# the Lacework sub-account account-3
module "aws_config_account-3" {
  source = "../../"

  providers = {
    lacework = lacework.account-3
    aws      = aws.account-3
  }

  lacework_integration_name = "account-3"
}
