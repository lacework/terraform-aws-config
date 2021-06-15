# AWS Configuration Assessment with Lacework using Existing IAM Role

This scenario integrates an AWS account with Lacework for cloud resource configuration assessment.

## Inputs

| Name                        | Description                                                                                                        | Type     |
| --------------------------- | ------------------------------------------------------------------------------------------------------------------ | -------- |
| `external_id_length`        | The length of the external ID to generate. Max length is 1224. Ignored when use_existing_iam_role is set to `true` | `number` |
| `iam_role_arn`              | The IAM role ARN is required when setting use_existing_iam_role to `true`                                          | `string` |
| `iam_role_external_id`      | The external ID configured inside the IAM role is required when setting use_existing_iam_role to `true`            | `string` |
| `iam_role_name`             | The IAM role name. Required to match with iam_role_arn if use_existing_iam_role is set to `true`                   | `string` |
| `lacework_integration_name` | The name of the integration in Lacework                                                                            | `string` |

## Sample Code

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
  version                   = "~> 0.1"

  use_existing_iam_role     = true
  iam_role_arn              = "arn:aws:iam::123456789012:role/lw-existing-role"
  iam_role_name             = "lw-existing-role"
  iam_role_external_id      = "H12d0TE22ab"

  lacework_integration_name = "account-abc"
}
```

For detailed information on integrating Lacework with AWS see [AWS Config and CloudTrail Integration with Terraform](https://support.lacework.com/hc/en-us/articles/360057092034-AWS-Config-and-CloudTrail-Integration-with-Terraform)
