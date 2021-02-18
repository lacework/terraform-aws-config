# Customized AWS Configuration Assessment with Lacework
This scenario integrates an AWS account with Lacework for cloud resource configuration assessment. The following example customizes the name of the IAM role used to provide Lacework access to the account, the integration display name in Lacework, and the external_id length for generating a external ID. 

| Name | Description | Type |
|------|-------------|------|
| `iam_role_name` | The IAM role name. Required to match with iam_role_arn if use_existing_iam_role is set to true | `string` |
| `lacework_integration_name` | Specifies the name of the integration in Lacework | `string` |
| `external_id_length` | The length of the external ID to generate. Max length is 1224. Ignored when use_existing_iam_role is set to `true` | `number` |

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
  iam_role_name             = "lw-custom-role"
  lacework_integration_name = "account-abc"
  external_id_length        = 1000
}
```

For detailed information on integrating Lacework with AWS see [AWS Config and CloudTrail Integration with Terraform](https://support.lacework.com/hc/en-us/articles/360057092034-AWS-Config-and-CloudTrail-Integration-with-Terraform)