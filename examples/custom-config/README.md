# Customized AWS Configuration Assessment with Lacework

This scenario integrates an AWS account with Lacework for cloud resource configuration assessment. The following example customizes the name of the IAM role used to provide Lacework access to the account, the integration
display name in Lacework, the Lacework audit policy name, and the external_id length for generating a external ID.

## Inputs

| Name                         | Description                                                                                                                                                         | Type     |
| ---------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------- |
| `iam_role_name`              | The IAM role name. Required to match with iam_role_arn if use_existing_iam_role is set to `true`                                                                    | `string` |
| `lacework_integration_name`  | Specifies the name of the integration in Lacework                                                                                                                   | `string` |
| `lacework_audit_policy_name` | The name of the custom audit policy (which extends SecurityAudit) to allow Lacework to read configs.  Defaults to `lwaudit-policy-${random_id.uniq.hex}` when empty | `string` |

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
  source                     = "lacework/config/aws"
  version                    = "~> 0.1"

  iam_role_name              = "lw-custom-role"
  lacework_integration_name  = "account-abc"
  lacework_audit_policy_name = "policy-abc"
}
```

For detailed information on integrating Lacework with AWS see [AWS Config and CloudTrail Integration with Terraform](https://support.lacework.com/hc/en-us/articles/360057092034-AWS-Config-and-CloudTrail-Integration-with-Terraform)
