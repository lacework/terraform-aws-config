# Multiple AWS accounts to multiple Lacework sub-accounts

This scenario integrates three AWS accounts into three Lacework sub-accounts for cloud resource configuration assessment.

Note that this example assumes that the workstation running this code has access to both, AWS accounts and your Lacework organization.

## Sample Code

```hcl
terraform {
  required_providers {
    lacework = {
      source = "lacework/lacework"
    }
  }
}

# Provider that access Lacework sub-account named "account-1"
provider "lacework" {
  subaccount = "account-1"
  alias      = "account-1"
}

# Provider that access Lacework sub-account named "account-2"
provider "lacework" {
  subaccount = "account-2"
  alias      = "account-2"
}

# Provider that access Lacework sub-account named "account-3"
provider "lacework" {
  subaccount = "account-3"
  alias      = "account-3"
}

# Provider that access AWS account "1234567890101"
provider "aws" {
  profile = "1234567890101"
  alias   = "account-1"
}

# Provider that access AWS account "1234567890102"
provider "aws" {
  profile = "1234567890102"
  alias   = "account-1"
}

# Provider that access AWS account "1234567890103"
provider "aws" {
  profile = "1234567890103"
  alias   = "account-1"
}

# Configures a compliance integration of the AWS account-1 to
# the Lacework sub-account account-1
module "aws_config_account-1" {
  source  = "lacework/config/aws"
  version = "~> 0.1"

  providers = {
    lacework = lacework.account-1
    aws      = aws.account-1
  }

  lacework_integration_name = "account-1"
}

# Configures a compliance integration of the AWS account-2 to
# the Lacework sub-account account-2
module "aws_config_account-2" {
  source  = "lacework/config/aws"
  version = "~> 0.1"

  providers = {
    lacework = lacework.account-2
    aws      = aws.account-2
  }

  lacework_integration_name = "account-2"
}

# Configures a compliance integration of the AWS account-3 to
# the Lacework sub-account account-3
module "aws_config_account-3" {
  source  = "lacework/config/aws"
  version = "~> 0.1"

  providers = {
    lacework = lacework.account-3
    aws      = aws.account-3
  }

  lacework_integration_name = "account-3"
}
```
