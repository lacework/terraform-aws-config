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
  version                 = "~> 0.4"
  create                  = var.use_existing_iam_role ? false : true
  iam_role_name           = var.iam_role_name
  permission_boundary_arn = var.permission_boundary_arn
  lacework_aws_account_id = var.lacework_aws_account_id
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

  statement {
    sid = "EFS"
    actions = ["elasticfilesystem:DescribeFileSystemPolicy",
      "elasticfilesystem:DescribeLifecycleConfiguration",
      "elasticfilesystem:DescribeAccessPoints",
      "elasticfilesystem:DescribeAccountPreferences",
      "elasticfilesystem:DescribeBackupPolicy",
    "elasticfilesystem:DescribeReplicationConfigurations"]
    resources = ["*"]
  }

  statement {
    sid = "EMR"
    actions = ["elasticmapreduce:ListBootstrapActions",
      "elasticmapreduce:ListInstanceFleets",
    "elasticmapreduce:ListInstanceGroups"]
    resources = ["*"]
  }

  statement {
    sid = "SAGEMAKER"
    actions = ["sagemaker:GetModelPackageGroupPolicy",
    "sagemaker:GetLineageGroupPolicy"]
    resources = ["*"]
  }

  statement {
    sid = "IDENTITYSTORE"
    actions = ["identitystore:DescribeGroup",
      "identitystore:DescribeGroupMembership",
      "identitystore:DescribeUser",
      "identitystore:ListGroupMemberships",
      "identitystore:ListGroupMembershipsForMember",
      "identitystore:ListGroups",
    "identitystore:ListUsers"]
    resources = ["*"]
  }

  statement {
    sid = "SSO"
    actions = ["sso:DescribeAccountAssignmentDeletionStatus",
      "sso:DescribeInstanceAccessControlAttributeConfiguration",
    "sso:GetInlinePolicyForPermissionSet"]
    resources = ["*"]
  }

  statement {
    sid = "APIGATEWAY"
    actions = ["apigateway:GetApiKeys",
      "apigateway:GetAuthorizers",
      "apigateway:GetBasePathMappings",
      "apigateway:GetClientCertificates",
      "apigateway:GetDeployments",
      "apigateway:GetDocumentationParts",
      "apigateway:GetDocumentationVersions",
      "apigateway:GetDomainNames",
      "apigateway:GetGatewayResponses",
      "apigateway:GetModels",
      "apigateway:GetModelTemplate",
      "apigateway:GetRequestValidators",
      "apigateway:GetResources",
      "apigateway:GetRestApis",
      "apigateway:GetSdk",
      "apigateway:GetSdkTypes",
      "apigateway:GetStages",
      "apigateway:GetTags",
      "apigateway:GetUsagePlanKeys",
      "apigateway:GetUsagePlans",
    "apigateway:GetVpcLinks"]
    resources = ["*"]
  }

  statement {
    sid = "APIGATEWAYV2"
    actions = ["apigatewayv2:GetApis",
      "apigatewayv2:GetApiMappings",
      "apigatewayv2:GetAuthorizers",
      "apigatewayv2:GetDeployments",
      "apigatewayv2:GetDomainNames",
      "apigatewayv2:GetIntegrations",
      "apigatewayv2:GetIntegrationResponses",
      "apigatewayv2:GetModelTemplate",
      "apigatewayv2:GetModels",
      "apigatewayv2:GetRoute",
      "apigatewayv2:GetRouteResponses",
      "apigatewayv2:GetStages",
    "apigatewayv2:GetVpcLinks"]
    resources = ["*"]
  }
  statement {
    sid = "WAFREGIONAL"
    actions = ["waf-regional:ListRules",
      "waf-regional:GetRule",
      "waf-regional:ListRuleGroups",
      "waf-regional:GetRuleGroup",
      "waf-regional:ListActivatedRulesInRuleGroup"]
     resources = ["*"]
  }
  statement {
    sid = "GLUE"
    actions = ["glue:ListWorkflows",
      "glue:BatchGetWorkflows",
      "glue:GetTags"]
    resources = ["*"]
  }

  statement {
    sid = "CODEBUILD"
    actions = ["codebuild:ListBuilds",
      "codebuild:BatchGetBuilds",
    ]
    resources = ["*"]
  }

  statement {
    sid = "SNS"
    actions = ["sns:GetDataProtectionPolicy",
      "sns:ListPlatformApplications",
      "sns:GetSubscriptionAttributes",
    ]
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
