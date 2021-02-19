# Default AWS Configuration Assessment with Lacework
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
  source  = "lacework/config/aws"
  version = "~> 0.1.3"
}
```

For detailed information on integrating Lacework with AWS see [AWS Config and CloudTrail Integration with Terraform](https://support.lacework.com/hc/en-us/articles/360057092034-AWS-Config-and-CloudTrail-Integration-with-Terraform)
