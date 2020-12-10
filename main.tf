locals {
  iam_role_arn         = module.lacework_cfg_iam_role.created ? module.lacework_cfg_iam_role.arn : var.iam_role_arn
  iam_role_external_id = module.lacework_cfg_iam_role.created ? module.lacework_cfg_iam_role.external_id : var.iam_role_external_id
}

module "lacework_cfg_iam_role" {
  source                  = "lacework/iam-role/aws"
  version                 = "~> 0.1.0"
  create                  = var.use_existing_iam_role ? false : true
  iam_role_name           = var.iam_role_name
  lacework_aws_account_id = var.lacework_aws_account_id
  external_id_length      = var.external_id_length
  tags                    = var.tags
}

resource "aws_iam_role_policy_attachment" "security_audit_policy_attachment" {
  role       = var.iam_role_name
  policy_arn = "arn:aws:iam::aws:policy/SecurityAudit"
  depends_on = [module.lacework_cfg_iam_role]
}

# wait for X seconds for things to settle down in the AWS side
# before trying to create the Lacework external integration
resource "time_sleep" "wait_time" {
  create_duration = var.wait_time
  depends_on      = [aws_iam_role_policy_attachment.security_audit_policy_attachment]
}

resource "lacework_integration_aws_cfg" "default" {
  name = var.lacework_integration_name
  credentials {
    role_arn    = local.iam_role_arn
    external_id = local.iam_role_external_id
  }
  depends_on = [time_sleep.wait_time]
}
