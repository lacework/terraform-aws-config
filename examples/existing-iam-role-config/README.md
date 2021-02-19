# AWS Configuration Assessment with Lacework using Existing IAM Role
This scenario integrates an AWS account with Lacework for cloud resource configuration assessment.

```hcl
terraform {
  required_providers {
    lacework = {
      source = "lacework/lacework"
    }
  }
}

provider "lacework" {}

provider "aws" {}

module "aws_config" {
  source                    = "lacework/config/aws"
  version                   = "~> 0.1.3"
  use_existing_iam_role     = true
  iam_role_arn              = "arn:aws:iam::123456789012:role/lw-existing-role"
  iam_role_name             = "lw-existing-role"
  iam_role_external_id      = "H12d0TE22ab"
  lacework_integration_name = "account-abc"
}
```

For detailed information on integrating Lacework with AWS see [AWS Config and CloudTrail Integration with Terraform](https://support.lacework.com/hc/en-us/articles/360057092034-AWS-Config-and-CloudTrail-Integration-with-Terraform)
