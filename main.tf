locals {
  iam_role_arn         = module.lacework_cfg_iam_role.created ? module.lacework_cfg_iam_role.arn : var.iam_role_arn
  iam_role_name        = module.lacework_cfg_iam_role.created ? module.lacework_cfg_iam_role.name : var.iam_role_name
  iam_role_external_id = module.lacework_cfg_iam_role.created ? module.lacework_cfg_iam_role.external_id : var.iam_role_external_id
  lacework_audit_policy_name = (
    length(var.lacework_audit_policy_name) > 0 ? var.lacework_audit_policy_name : "lwaudit-policy-${random_id.uniq.hex}"
  )
}

resource "random_id" "uniq" {
  byte_length = 4
}

module "lacework_cfg_iam_role" {
  source                  = "lacework/iam-role/aws"
  version                 = "~> 0.2"
  create                  = var.use_existing_iam_role ? false : true
  iam_role_name           = var.iam_role_name
  permissions_boundary    = var.permission_boundary_arn
  lacework_aws_account_id = var.lacework_aws_account_id
  external_id_length      = var.external_id_length
  tags                    = var.tags
}

resource "aws_iam_role_policy_attachment" "security_audit_policy_attachment" {
  count      = var.use_existing_iam_role_policy ? 0 : 1
  role       = local.iam_role_name
  policy_arn = "arn:aws:iam::aws:policy/SecurityAudit"
  depends_on = [module.lacework_cfg_iam_role]
}

# Lacework custom configuration policy
data "aws_iam_policy_document" "lacework_audit_policy" {
  count   = var.use_existing_iam_role_policy ? 0 : 1
  version = "2012-10-17"

  statement {
    sid       = "GetEbsEncryptionByDefault"
    actions   = ["ec2:GetEbsEncryptionByDefault"]
    resources = ["*"]
  }

  statement {
    sid       = "GetBucketPublicAccessBlock"
    actions   = ["s3:GetBucketPublicAccessBlock"]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "lacework_audit_policy" {
  count       = var.use_existing_iam_role_policy ? 0 : 1
  name        = local.lacework_audit_policy_name
  description = "An audit policy to allow Lacework to read configs (extends SecurityAudit)"
  policy      = data.aws_iam_policy_document.lacework_audit_policy[0].json
  tags        = var.tags
}

resource "aws_iam_role_policy_attachment" "lacework_audit_policy_attachment" {
  count      = var.use_existing_iam_role_policy ? 0 : 1
  role       = local.iam_role_name
  policy_arn = aws_iam_policy.lacework_audit_policy[0].arn
  depends_on = [module.lacework_cfg_iam_role]
}

# wait for X seconds for things to settle down in the AWS side
# before trying to create the Lacework external integration
resource "time_sleep" "wait_time" {
  create_duration = var.wait_time
  depends_on = [
    aws_iam_role_policy_attachment.security_audit_policy_attachment,
    aws_iam_role_policy_attachment.lacework_audit_policy_attachment,
  ]
}

resource "lacework_integration_aws_cfg" "default" {
  name = var.lacework_integration_name
  credentials {
    role_arn    = local.iam_role_arn
    external_id = local.iam_role_external_id
  }
  depends_on = [time_sleep.wait_time]
}
