provider "lacework" {}

provider "aws" {}

module "aws_config" {
  source = "../../"

  iam_role_name              = "lw-custom-role"
  lacework_integration_name  = "account-abc"
  lacework_audit_policy_name = "policy-abc"
  external_id_length         = 1000
}
