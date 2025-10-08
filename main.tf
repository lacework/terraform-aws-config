data "aws_caller_identity" "current_aws_account" {}

locals {
  iam_role_arn         = module.lacework_cfg_iam_role.created ? module.lacework_cfg_iam_role.arn : var.iam_role_arn
  iam_role_name        = module.lacework_cfg_iam_role.created ? module.lacework_cfg_iam_role.name : var.iam_role_name
  iam_role_external_id = module.lacework_cfg_iam_role.created ? module.lacework_cfg_iam_role.external_id : var.iam_role_external_id
  lacework_audit_policy_name = (
    length(var.lacework_audit_policy_name) > 0 ? var.lacework_audit_policy_name : "lwaudit-policy-${random_id.uniq.hex}-${data.aws_caller_identity.current_aws_account.account_id}"
  )
  lacework_audit_policy_name_2025_1 = "${local.lacework_audit_policy_name}-2025-1"
  lacework_audit_policy_name_2025_2 = "${local.lacework_audit_policy_name}-2025-2"
  lacework_audit_policy_name_2025_3 = "${local.lacework_audit_policy_name}-2025-3"
  lacework_audit_policy_name_2025_4 = "${local.lacework_audit_policy_name}-2025-4"
  lacework_audit_policy_name_2025_5 = "${local.lacework_audit_policy_name}-2025-5"
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
  count = var.use_existing_iam_role_policy ? 0 : 1

  role       = local.iam_role_name
  policy_arn = "arn:aws:iam::aws:policy/SecurityAudit"
  depends_on = [module.lacework_cfg_iam_role]
}

# Lacework custom configuration policy
data "aws_iam_policy_document" "lacework_audit_policy" {
  count = var.use_existing_iam_role_policy ? 0 : 1

  statement {
    sid       = "EFS"
    actions   = ["elasticfilesystem:ListTagsForResource"]
    resources = ["*"]
  }

  statement {
    sid = "EMR"
    actions = [
      "elasticmapreduce:ListBootstrapActions",
      "elasticmapreduce:ListInstanceFleets",
      "elasticmapreduce:ListInstanceGroups",
    ]
    resources = ["*"]
  }

  statement {
    sid = "SAGEMAKER"
    actions = [
      "sagemaker:GetDeviceFleetReport",
      "sagemaker:GetLineageGroupPolicy",
      "sagemaker:GetModelPackageGroupPolicy",
    ]
    resources = ["*"]
  }

  statement {
    sid = "IDENTITYSTORE"
    actions = [
      "identitystore:DescribeGroup",
      "identitystore:DescribeGroupMembership",
      "identitystore:DescribeUser",
    ]
    resources = ["*"]
  }

  statement {
    sid = "SSO"
    actions = [
      "sso:DescribeAccountAssignmentDeletionStatus",
      "sso:DescribeInstanceAccessControlAttributeConfiguration",
      "sso:GetInlinePolicyForPermissionSet",
    ]
    resources = ["*"]
  }

  statement {
    sid     = "APIGATEWAY"
    actions = ["apigateway:GET"]
    resources = [
      "arn:aws:apigateway:*::/apikeys",
      "arn:aws:apigateway:*::/apikeys/*",
      "arn:aws:apigateway:*::/domainnames/*",
      "arn:aws:apigateway:*::/domainnames/*/basepathmappings",
      "arn:aws:apigateway:*::/domainnames/*/basepathmappings/*",
      "arn:aws:apigateway:*::/sdktypes",
      "arn:aws:apigateway:*::/sdktypes/*",
      "arn:aws:apigateway:*::/usageplans",
      "arn:aws:apigateway:*::/usageplans/*",
    ]
  }

  statement {
    sid = "GLACIER"
    actions = [
      "glacier:GetJobOutput",
      "glacier:GetVaultNotifications",
      "glacier:ListJobs",
      "glacier:ListMultipartUploads",
      "glacier:ListParts",
      "glacier:ListProvisionedCapacity",
      "glacier:ListTagsForVault",
    ]
    resources = ["*"]
  }

  statement {
    sid = "GLUE"
    actions = [
      "glue:BatchGetWorkflows",
      "glue:GetTables",
      "glue:GetWorkflow",
      "glue:ListWorkflows",
    ]
    resources = ["*"]
  }

  statement {
    sid = "CODEBUILD"
    actions = [
      "codebuild:BatchGetBuildBatches",
      "codebuild:BatchGetBuilds",
      "codebuild:BatchGetReportGroups",
      "codebuild:BatchGetReports",
      "codebuild:DescribeCodeCoverages",
      "codebuild:DescribeTestCases",
      "codebuild:ListBuildBatches",
      "codebuild:ListBuilds",
      "codebuild:ListCuratedEnvironmentImages",
      "codebuild:ListReportGroups",
      "codebuild:ListReports",
      "codebuild:ListSharedProjects",
      "codebuild:ListSharedReportGroups",
    ]
    resources = ["*"]
  }

  statement {
    sid = "SNS"
    actions = [
      "sns:GetDataProtectionPolicy",
      "sns:GetSubscriptionAttributes",
      "sns:ListPlatformApplications",
    ]
    resources = ["*"]
  }

  statement {
    sid       = "STATES"
    actions   = ["states:ListTagsForResource"]
    resources = ["*"]
  }

  statement {
    sid = "SES"
    actions = [
      "ses:GetContact",
      "ses:GetContactList",
      "ses:GetCustomVerificationEmailTemplate",
      "ses:GetDedicatedIpPool",
      "ses:GetDeliverabilityTestReport",
      "ses:GetEmailIdentity",
      "ses:GetEmailIdentityPolicies",
      "ses:GetEmailTemplate",
      "ses:GetImportJob",
      "ses:GetSuppressedDestination",
      "ses:ListContactLists",
      "ses:ListContacts",
      "ses:ListCustomVerificationEmailTemplates",
      "ses:ListDeliverabilityTestReports",
      "ses:ListEmailIdentities",
      "ses:ListEmailTemplates",
      "ses:ListImportJobs",
      "ses:ListRecommendations",
      "ses:ListSuppressedDestinations",
      "ses:ListTagsForResource",
    ]
    resources = ["*"]
  }

  statement {
    sid = "BACKUP"
    actions = [
      "backup:DescribeBackupJob",
      "backup:DescribeBackupVault",
      "backup:DescribeFramework",
      "backup:DescribeProtectedResource",
      "backup:DescribeRecoveryPoint",
      "backup:GetBackupPlan",
      "backup:GetBackupPlanFromTemplate",
      "backup:GetBackupSelection",
      "backup:GetLegalHold",
      "backup:GetRecoveryPointRestoreMetadata",
      "backup:ListBackupJobs",
      "backup:ListBackupPlanTemplates",
      "backup:ListBackupPlanVersions",
      "backup:ListBackupPlans",
      "backup:ListBackupSelections",
      "backup:ListCopyJobs",
      "backup:ListFrameworks",
      "backup:ListLegalHolds",
      "backup:ListProtectedResources",
      "backup:ListRecoveryPointsByBackupVault",
      "backup:ListRecoveryPointsByLegalHold",
      "backup:ListRecoveryPointsByResource",
      "backup:ListReportPlans",
      "backup:ListRestoreJobs",
    ]
    resources = ["*"]
  }

  statement {
    sid = "COGNITOIDP"
    actions = [
      "cognito-idp:GetCSVHeader",
      "cognito-idp:GetSigningCertificate",
      "cognito-idp:GetUICustomization",
      "cognito-idp:GetUserPoolMfaConfig",
    ]
    resources = ["*"]
  }

  statement {
    sid = "COMPUTEOPTIMIZER"
    actions = [
      "compute-optimizer:DescribeRecommendationExportJobs",
      "compute-optimizer:GetAutoScalingGroupRecommendations",
      "compute-optimizer:GetEBSVolumeRecommendations",
      "compute-optimizer:GetEC2InstanceRecommendations",
      "compute-optimizer:GetEcsServiceRecommendations",
      "compute-optimizer:GetEffectiveRecommendationPreferences",
      "compute-optimizer:GetEnrollmentStatus",
      "compute-optimizer:GetLambdaFunctionRecommendations",
      "compute-optimizer:GetLicenseRecommendations",
      "compute-optimizer:GetRecommendationPreferences",
      "compute-optimizer:GetRecommendationSummaries",
    ]
    resources = ["*"]
  }

  statement {
    sid = "KINESISANALYTICS"
    actions = [
      "kinesisanalytics:DescribeApplication",
      "kinesisanalytics:DescribeApplicationVersion",
      "kinesisanalytics:ListApplicationSnapshots",
      "kinesisanalytics:ListApplicationVersions",
    ]
    resources = ["*"]
  }

  statement {
    sid = "KINESISVIDEO"
    actions = [
      "kinesisvideo:DescribeImageGenerationConfiguration",
      "kinesisvideo:GetDataEndpoint",
      "kinesisvideo:GetSignalingChannelEndpoint",
    ]
    resources = ["*"]
  }

  statement {
    sid = "AMP"
    actions = [
      "aps:DescribeAlertManagerDefinition",
      "aps:DescribeLoggingConfiguration",
      "aps:DescribeRuleGroupsNamespace",
      "aps:DescribeScraper",
      "aps:DescribeWorkspace",
      "aps:ListRuleGroupsNamespaces",
      "aps:ListScrapers",
      "aps:ListTagsForResource",
      "aps:ListWorkspaces",
    ]
    resources = ["*"]
  }
}

# AWS iam allows only 6144 characters in a single policy
# We've come to a point where there are too many actions in a single policy which is causing the policy to exceed the limit
# So we needed a new policy to accommodate the overflow of actions, thus we added this new policy "lacework_audit_policy_2025_1"
# Which representing the first new policy in 2025
data "aws_iam_policy_document" "lacework_audit_policy_2025_1" {
  count = var.use_existing_iam_role_policy ? 0 : 1

  statement {
    sid = "APPSTREAM"
    actions = [
      "appstream:Describe*",
      "appstream:List*",
    ]
    resources = ["*"]
  }

  statement {
    sid = "PERSONALIZE"
    actions = [
      "personalize:Describe*",
      "personalize:GetSolutionMetrics",
      "personalize:List*",
    ]
    resources = ["*"]
  }

  statement {
    sid = "CODEARTIFACT"
    actions = [
      "codeartifact:DescribeDomain",
      "codeartifact:DescribePackage",
      "codeartifact:DescribePackageVersion",
      "codeartifact:DescribeRepository",
      "codeartifact:GetPackageVersionAsset",
      "codeartifact:GetPackageVersionReadme",
      "codeartifact:GetRepositoryEndpoint",
      "codeartifact:ListDomains",
      "codeartifact:ListPackageVersionAssets",
      "codeartifact:ListPackageVersionDependencies",
      "codeartifact:ListPackageVersions",
      "codeartifact:ListPackages",
      "codeartifact:ListTagsForResource",
    ]
    resources = ["*"]
  }

  statement {
    sid = "FIS"
    actions = [
      "fis:GetAction",
      "fis:GetExperiment",
      "fis:GetExperimentTemplate",
      "fis:ListActions",
      "fis:ListExperimentResolvedTargets",
      "fis:ListExperimentTemplates",
      "fis:ListExperiments",
      "fis:ListTagsForResource",
      "fis:ListTargetAccountConfigurations",
    ]
    resources = ["*"]
  }

  statement {
    sid = "MEMORYDB"
    actions = [
      "memorydb:DescribeACLs",
      "memorydb:DescribeEngineVersions",
      "memorydb:DescribeMultiRegionClusters",
      "memorydb:DescribeParameterGroups",
      "memorydb:DescribeParameters",
      "memorydb:DescribeReservedNodes",
      "memorydb:DescribeReservedNodesOfferings",
      "memorydb:DescribeServiceUpdates",
      "memorydb:DescribeSnapshots",
      "memorydb:DescribeSubnetGroups",
      "memorydb:DescribeUsers",
      "memorydb:ListAllowedMultiRegionClusterUpdates",
      "memorydb:ListAllowedNodeTypeUpdates",
      "memorydb:ListTags",
    ]
    resources = ["*"]
  }

  statement {
    sid = "QBUSINESS"
    actions = [
      "qbusiness:GetApplication",
      "qbusiness:GetChatControlsConfiguration",
      "qbusiness:GetDataAccessor",
      "qbusiness:GetDataSource",
      "qbusiness:GetIndex",
      "qbusiness:GetPlugin",
      "qbusiness:GetPolicy",
      "qbusiness:GetRetriever",
      "qbusiness:GetWebExperience",
      "qbusiness:ListAttachments",
      "qbusiness:ListConversations",
      "qbusiness:ListDataAccessors",
      "qbusiness:ListMessages",
      "qbusiness:ListPluginActions",
      "qbusiness:ListPluginTypeActions",
      "qbusiness:ListPluginTypeMetadata",
    ]
    resources = ["*"]
  }

  statement {
    sid = "QAPPS"
    actions = [
      "qapps:DescribeQAppPermissions",
      "qapps:GetLibraryItem",
      "qapps:GetQApp",
      "qapps:GetQAppSession",
      "qapps:GetQAppSessionMetadata",
      "qapps:ListCategories",
      "qapps:ListLibraryItems",
      "qapps:ListQAppSessionData",
      "qapps:ListQApps",
      "qapps:ListTagsForResource",
    ]
    resources = ["*"]
  }

  statement {
    sid = "QCONNECT"
    actions = [
      "wisdom:GetAIAgent",
      "wisdom:GetAIGuardrail",
      "wisdom:GetAIPrompt",
      "wisdom:GetContent",
      "wisdom:GetImportJob",
      "wisdom:GetKnowledgeBase",
      "wisdom:GetMessageTemplate",
      "wisdom:GetQuickResponse",
      "wisdom:ListAIAgentVersions",
      "wisdom:ListAIAgents",
      "wisdom:ListAIGuardrailVersions",
      "wisdom:ListAIGuardrails",
      "wisdom:ListAIPromptVersions",
      "wisdom:ListAIPrompts",
      "wisdom:ListAssistantAssociations",
      "wisdom:ListAssistants",
      "wisdom:ListContentAssociations",
      "wisdom:ListContents",
      "wisdom:ListImportJobs",
      "wisdom:ListKnowledgeBases",
      "wisdom:ListMessageTemplateVersions",
      "wisdom:ListMessageTemplates",
      "wisdom:ListQuickResponses",
      "wisdom:ListTagsForResource",
    ]
    resources = ["*"]
  }

  statement {
    sid = "RESOURCEGROUPS"
    actions = [
      "resource-groups:GetGroupConfiguration",
      "resource-groups:GetGroupQuery",
      "resource-groups:GetTags",
      "resource-groups:ListGroups",
    ]
    resources = ["*"]
  }

  statement {
    sid = "SERVICECATALOGAPPREGISTRY"
    actions = [
      "servicecatalog:GetApplication",
      "servicecatalog:GetAssociatedResource",
      "servicecatalog:GetAttributeGroup",
      "servicecatalog:GetConfiguration",
      "servicecatalog:ListApplications",
      "servicecatalog:ListAssociatedAttributeGroups",
      "servicecatalog:ListAssociatedResources",
      "servicecatalog:ListAttributeGroups",
      "servicecatalog:ListAttributeGroupsForApplication",
      "servicecatalog:ListTagsForResource",
    ]
    resources = ["*"]
  }

  statement {
    sid = "OAM"
    actions = [
      "oam:GetLink",
      "oam:GetSink",
      "oam:GetSinkPolicy",
      "oam:ListAttachedLinks",
      "oam:ListLinks",
      "oam:ListSinks",
    ]
    resources = ["*"]
  }

  statement {
    sid = "CLOUDDIRECTORY"
    actions = [
      "clouddirectory:GetAppliedSchemaVersion",
      "clouddirectory:GetDirectory",
      "clouddirectory:GetFacet",
      "clouddirectory:GetLinkAttributes",
      "clouddirectory:GetObjectAttributes",
      "clouddirectory:GetObjectInformation",
      "clouddirectory:GetSchemaAsJson",
      "clouddirectory:GetTypedLinkFacetInformation",
      "clouddirectory:ListAppliedSchemaArns",
      "clouddirectory:ListAttachedIndices",
      "clouddirectory:ListDevelopmentSchemaArns",
      "clouddirectory:ListFacetAttributes",
      "clouddirectory:ListFacetNames",
      "clouddirectory:ListIncomingTypedLinks",
      "clouddirectory:ListIndex",
      "clouddirectory:ListManagedSchemaArns",
      "clouddirectory:ListObjectAttributes",
      "clouddirectory:ListObjectChildren",
      "clouddirectory:ListObjectParentPaths",
      "clouddirectory:ListObjectParents",
      "clouddirectory:ListObjectPolicies",
      "clouddirectory:ListOutgoingTypedLinks",
      "clouddirectory:ListPolicyAttachments",
      "clouddirectory:ListPublishedSchemaArns",
      "clouddirectory:ListTagsForResource",
      "clouddirectory:ListTypedLinkFacetAttributes",
      "clouddirectory:ListTypedLinkFacetNames",
    ]
    resources = ["*"]
  }

  statement {
    sid = "COSTOPTIMIZATIONHUB"
    actions = [
      "cost-optimization-hub:GetPreferences",
      "cost-optimization-hub:GetRecommendation",
      "cost-optimization-hub:ListEnrollmentStatuses",
      "cost-optimization-hub:ListRecommendationSummaries",
      "cost-optimization-hub:ListRecommendations",
    ]
    resources = ["*"]
  }

  statement {
    sid = "BUDGETS"
    actions = [
      "budgets:DescribeBudgetAction",
      "budgets:DescribeBudgetActionHistories",
      "budgets:DescribeBudgetActionsForAccount",
      "budgets:DescribeBudgetActionsForBudget",
      "budgets:ListTagsForResource",
      "budgets:ViewBudget",
    ]
    resources = ["*"]
  }

  statement {
    sid       = "BILLING"
    actions   = ["billing:GetBillingViewData"]
    resources = ["*"]
  }

  statement {
    sid = "BILLINGCONSOLE"
    actions = [
      "aws-portal:GetConsoleActionSetEnforced",
      "aws-portal:ViewAccount",
      "aws-portal:ViewBilling",
      "aws-portal:ViewPaymentMethods",
      "aws-portal:ViewUsage",
    ]
    resources = ["*"]
  }
}


# New permission incoming for 20.0.0 release:
# https://lacework.atlassian.net/browse/RAIN-94565
data "aws_iam_policy_document" "lacework_audit_policy_2025_2" {
  count = var.use_existing_iam_role_policy ? 0 : 1

  statement {
    sid       = "FREETIER"
    actions   = ["freetier:GetFreeTierUsage"]
    resources = ["*"]
  }

  statement {
    sid = "WAFREGIONAL"
    actions = [
      "waf-regional:GetByteMatchSet",
      "waf-regional:GetGeoMatchSet",
      "waf-regional:GetIPSet",
      "waf-regional:GetLoggingConfiguration",
      "waf-regional:GetPermissionPolicy",
      "waf-regional:GetRateBasedRule",
      "waf-regional:GetRegexMatchSet",
      "waf-regional:GetRegexPatternSet",
      "waf-regional:GetRule",
      "waf-regional:GetRuleGroup",
      "waf-regional:GetSizeConstraintSet",
      "waf-regional:GetSqlInjectionMatchSet",
      "waf-regional:GetXssMatchSet",
      "waf-regional:ListActivatedRulesInRuleGroup",
      "waf-regional:ListByteMatchSets",
      "waf-regional:ListGeoMatchSets",
      "waf-regional:ListIpSets",
      "waf-regional:ListRateBasedRules",
      "waf-regional:ListRegexMatchSets",
      "waf-regional:ListRegexPatternSets",
      "waf-regional:ListRuleGroups",
      "waf-regional:ListRules",
      "waf-regional:ListSizeConstraintSets",
      "waf-regional:ListSqlInjectionMatchSets",
      "waf-regional:ListXssMatchSets",
    ]
    resources = ["*"]
  }

  statement {
    sid = "ACMPCA"
    actions = [
      "acm-pca:GetCertificateAuthorityCertificate",
      "acm-pca:GetCertificateAuthorityCsr",
    ]
    resources = ["*"]
  }

  statement {
    sid = "APPCONFIG"
    actions = [
      "appconfig:GetConfigurationProfile",
      "appconfig:GetDeployment",
      "appconfig:GetDeploymentStrategy",
      "appconfig:GetExtension",
      "appconfig:GetExtensionAssociation",
      "appconfig:GetHostedConfigurationVersion",
      "appconfig:ListApplications",
      "appconfig:ListConfigurationProfiles",
      "appconfig:ListDeploymentStrategies",
      "appconfig:ListDeployments",
      "appconfig:ListEnvironments",
      "appconfig:ListExtensionAssociations",
      "appconfig:ListExtensions",
      "appconfig:ListHostedConfigurationVersions",
      "appconfig:ListTagsForResource",
    ]
    resources = ["*"]
  }

  statement {
    sid = "APPFLOW"
    actions = [
      "appflow:DescribeConnector",
      "appflow:DescribeConnectorEntity",
      "appflow:DescribeConnectorProfiles",
      "appflow:DescribeFlow",
      "appflow:DescribeFlowExecutionRecords",
      "appflow:ListConnectorEntities",
      "appflow:ListConnectors",
    ]
    resources = ["*"]
  }

  statement {
    sid = "DYNAMODB"
    actions = [
      "dynamodb:DescribeBackup",
      "dynamodb:DescribeContributorInsights",
      "dynamodb:GetResourcePolicy",
    ]
    resources = ["*"]
  }

  statement {
    sid = "EBS"
    actions = [
      "ebs:GetSnapshotBlock",
      "ebs:ListSnapshotBlocks",
    ]
    resources = ["*"]
  }

  statement {
    sid = "LAKEFORMATION"
    actions = [
      "lakeformation:DescribeLakeFormationIdentityCenterConfiguration",
      "lakeformation:GetDataLakePrincipal",
      "lakeformation:GetDataLakeSettings",
      "lakeformation:GetEffectivePermissionsForPath",
      "lakeformation:GetTableObjects",
      "lakeformation:ListDataCellsFilter",
      "lakeformation:ListPermissions",
      "lakeformation:ListResources",
      "lakeformation:ListTableStorageOptimizers",
      "lakeformation:ListTransactions",
    ]
    resources = ["*"]
  }

  statement {
    sid = "LAMBDA"
    actions = [
      "lambda:GetFunction",
      "lambda:GetFunctionCodeSigningConfig",
    ]
    resources = ["*"]
  }

  statement {
    sid = "SCHEDULER"
    actions = [
      "scheduler:GetSchedule",
      "scheduler:GetScheduleGroup",
      "scheduler:ListScheduleGroups",
      "scheduler:ListSchedules",
      "scheduler:ListTagsForResource",
    ]
    resources = ["*"]
  }

  statement {
    sid       = "SCHEMAS"
    actions   = ["schemas:GetCodeBindingSource"]
    resources = ["*"]
  }

  statement {
    sid = "DATASYNC"
    actions = [
      "datasync:DescribeAgent",
      "datasync:DescribeDiscoveryJob",
      "datasync:DescribeLocationAzureBlob",
      "datasync:DescribeLocationEfs",
      "datasync:DescribeLocationFsxLustre",
      "datasync:DescribeLocationFsxWindows",
      "datasync:DescribeLocationHdfs",
      "datasync:DescribeLocationNfs",
      "datasync:DescribeLocationObjectStorage",
      "datasync:DescribeLocationS3",
      "datasync:DescribeLocationSmb",
      "datasync:DescribeStorageSystem",
      "datasync:DescribeTask",
      "datasync:DescribeTaskExecution",
      "datasync:ListAgents",
      "datasync:ListDiscoveryJobs",
      "datasync:ListLocations",
      "datasync:ListStorageSystems",
      "datasync:ListTagsForResource",
      "datasync:ListTaskExecutions",
      "datasync:ListTasks",
    ]
    resources = ["*"]
  }

  statement {
    sid = "RESILIENCEHUB"
    actions = [
      "resiliencehub:DescribeApp",
      "resiliencehub:DescribeAppAssessment",
      "resiliencehub:DescribeAppVersion",
      "resiliencehub:DescribeAppVersionResource",
      "resiliencehub:DescribeAppVersionResourcesResolutionStatus",
      "resiliencehub:DescribeAppVersionTemplate",
      "resiliencehub:DescribeDraftAppVersionResourcesImportStatus",
      "resiliencehub:DescribeResourceGroupingRecommendationTask",
      "resiliencehub:ListAlarmRecommendations",
      "resiliencehub:ListAppAssessmentComplianceDrifts",
      "resiliencehub:ListAppAssessmentResourceDrifts",
      "resiliencehub:ListAppAssessments",
      "resiliencehub:ListAppComponentCompliances",
      "resiliencehub:ListAppComponentRecommendations",
      "resiliencehub:ListAppInputSources",
      "resiliencehub:ListAppVersionAppComponents",
      "resiliencehub:ListAppVersionResourceMappings",
      "resiliencehub:ListAppVersionResources",
      "resiliencehub:ListAppVersions",
      "resiliencehub:ListApps",
      "resiliencehub:ListRecommendationTemplates",
      "resiliencehub:ListResiliencyPolicies",
      "resiliencehub:ListResourceGroupingRecommendations",
      "resiliencehub:ListSopRecommendations",
      "resiliencehub:ListSuggestedResiliencyPolicies",
      "resiliencehub:ListTagsForResource",
      "resiliencehub:ListTestRecommendations",
      "resiliencehub:ListUnsupportedAppVersionResources",
    ]
    resources = ["*"]
  }

  statement {
    sid = "STEPFUNCTIONS"
    actions = [
      "states:DescribeExecution",
      "states:DescribeMapRun",
      "states:GetActivityTask",
      "states:GetExecutionHistory",
      "states:ListActivities",
      "states:ListExecutions",
      "states:ListMapRuns",
    ]
    resources = ["*"]
  }
}

# New permission incoming for 21.0.0 release contain 13 new services:
# https://lacework.atlassian.net/browse/RAIN-95014
data "aws_iam_policy_document" "lacework_audit_policy_2025_3" {
  count = var.use_existing_iam_role_policy ? 0 : 1

  statement {
    sid = "IOT"
    actions = [
      "iot:GetBehaviorModelTrainingSummaries",
      "iot:GetCommand",
      "iot:GetCommandExecution",
      "iot:GetEffectivePolicies",
      "iot:GetIndexingConfiguration",
      "iot:GetJobDocument",
      "iot:GetOtaUpdate",
      "iot:GetPackage",
      "iot:GetPackageConfiguration",
      "iot:GetPackageVersion",
      "iot:GetRegistrationCode",
      "iot:GetThingConnectivityData",
      "iot:GetTopicRule",
      "iot:GetTopicRuleDestination",
      "iot:GetV2LoggingOptions",
    ]
    resources = ["*"]
  }

  statement {
    sid = "IOTEVENTS"
    actions = [
      "iotevents:DescribeAlarmModel",
      "iotevents:DescribeDetectorModel",
      "iotevents:DescribeInput",
      "iotevents:DescribeLoggingOptions",
      "iotevents:ListAlarmModelVersions",
      "iotevents:ListAlarmModels",
      "iotevents:ListDetectorModelVersions",
      "iotevents:ListDetectorModels",
      "iotevents:ListTagsForResource",
    ]
    resources = ["*"]
  }

  statement {
    sid = "MEDIAPACKAGE"
    actions = [
      "mediapackage:ListChannels",
      "mediapackage:ListHarvestJobs",
      "mediapackage:ListTagsForResource",
    ]
    resources = ["*"]
  }

  statement {
    sid = "MEDIAPACKAGEV2"
    actions = [
      "mediapackagev2:GetChannel",
      "mediapackagev2:GetChannelGroup",
      "mediapackagev2:GetChannelPolicy",
      "mediapackagev2:GetOriginEndpoint",
      "mediapackagev2:GetOriginEndpointPolicy",
      "mediapackagev2:ListChannelGroups",
      "mediapackagev2:ListChannels",
      "mediapackagev2:ListHarvestJobs",
      "mediapackagev2:ListOriginEndpoints",
      "mediapackagev2:ListTagsForResource",
    ]
    resources = ["*"]
  }

  statement {
    sid = "MEDIAPACKAGEVOD"
    actions = [
      "mediapackage-vod:DescribeAsset",
      "mediapackage-vod:ListAssets",
      "mediapackage-vod:ListPackagingConfigurations",
      "mediapackage-vod:ListPackagingGroups",
    ]
    resources = ["*"]
  }

  statement {
    sid = "SUPPORT"
    actions = [
      "support:DescribeCases",
      "support:DescribeCommunications",
      "support:DescribeServices",
      "support:DescribeSeverityLevels",
    ]
    resources = ["*"]
  }

  statement {
    sid = "IMAGEBUILDER"
    actions = [
      "imagebuilder:GetComponent",
      "imagebuilder:GetComponentPolicy",
      "imagebuilder:GetContainerRecipe",
      "imagebuilder:GetContainerRecipePolicy",
      "imagebuilder:GetDistributionConfiguration",
      "imagebuilder:GetImage",
      "imagebuilder:GetImagePipeline",
      "imagebuilder:GetImagePolicy",
      "imagebuilder:GetImageRecipe",
      "imagebuilder:GetImageRecipePolicy",
      "imagebuilder:GetInfrastructureConfiguration",
      "imagebuilder:GetLifecyclePolicy",
      "imagebuilder:GetWorkflow",
      "imagebuilder:GetWorkflowStepExecution",
      "imagebuilder:ListComponentBuildVersions",
      "imagebuilder:ListComponents",
      "imagebuilder:ListContainerRecipes",
      "imagebuilder:ListDistributionConfigurations",
      "imagebuilder:ListImageBuildVersions",
      "imagebuilder:ListImagePackages",
      "imagebuilder:ListImagePipelines",
      "imagebuilder:ListImageRecipes",
      "imagebuilder:ListImageScanFindingAggregations",
      "imagebuilder:ListImageScanFindings",
      "imagebuilder:ListImages",
      "imagebuilder:ListInfrastructureConfigurations",
      "imagebuilder:ListLifecycleExecutionResources",
      "imagebuilder:ListLifecycleExecutions",
      "imagebuilder:ListLifecyclePolicies",
      "imagebuilder:ListTagsForResource",
      "imagebuilder:ListWorkflowBuildVersions",
      "imagebuilder:ListWorkflowExecutions",
      "imagebuilder:ListWorkflowStepExecutions",
      "imagebuilder:ListWorkflows",
    ]
    resources = ["*"]
  }

  statement {
    sid = "DETECTIVE"
    actions = [
      "detective:BatchGetGraphMemberDatasources",
      "detective:BatchGetMembershipDatasources",
      "detective:GetInvestigation",
      "detective:ListDatasourcePackages",
      "detective:ListIndicators",
      "detective:ListInvestigations",
      "detective:ListInvitations",
      "detective:ListOrganizationAdminAccount",
      "detective:ListTagsForResource",
    ]
    resources = ["*"]
  }

  statement {
    sid = "BATCH"
    actions = [
      "batch:DescribeJobQueues",
      "batch:DescribeJobs",
      "batch:DescribeSchedulingPolicies",
      "batch:ListJobs",
      "batch:ListSchedulingPolicies",
      "batch:ListTagsForResource",
    ]
    resources = ["*"]
  }

  statement {
    sid = "NETWORKMANAGER"
    actions = [
      "networkmanager:GetConnectAttachment",
      "networkmanager:GetConnectPeer",
      "networkmanager:GetConnectPeerAssociations",
      "networkmanager:GetConnections",
      "networkmanager:GetCoreNetwork",
      "networkmanager:GetCoreNetworkChangeEvents",
      "networkmanager:GetCoreNetworkChangeSet",
      "networkmanager:GetCoreNetworkPolicy",
      "networkmanager:GetCustomerGatewayAssociations",
      "networkmanager:GetDevices",
      "networkmanager:GetLinkAssociations",
      "networkmanager:GetLinks",
      "networkmanager:GetNetworkResourceCounts",
      "networkmanager:GetNetworkResourceRelationships",
      "networkmanager:GetNetworkResources",
      "networkmanager:GetNetworkRoutes",
      "networkmanager:GetNetworkTelemetry",
      "networkmanager:GetResourcePolicy",
      "networkmanager:GetSiteToSiteVpnAttachment",
      "networkmanager:GetSites",
      "networkmanager:GetTransitGatewayConnectPeerAssociations",
      "networkmanager:GetTransitGatewayPeering",
      "networkmanager:GetTransitGatewayRegistrations",
      "networkmanager:GetTransitGatewayRouteTableAttachment",
      "networkmanager:GetVpcAttachment",
      "networkmanager:ListAttachments",
      "networkmanager:ListConnectPeers",
      "networkmanager:ListCoreNetworkPolicyVersions",
      "networkmanager:ListCoreNetworks",
      "networkmanager:ListPeerings",
    ]
    resources = ["*"]
  }

  statement {
    sid = "CODEPIPELINE"
    actions = [
      "codepipeline:GetActionType",
      "codepipeline:ListActionExecutions",
      "codepipeline:ListActionTypes",
      "codepipeline:ListPipelineExecutions",
      "codepipeline:ListRuleExecutions",
      "codepipeline:ListRuleTypes",
      "codepipeline:ListTagsForResource",
      "codepipeline:ListWebhooks",
    ]
    resources = ["*"]
  }

  statement {
    sid = "GREENGRASS"
    actions = [
      "greengrass:DescribeComponent",
      "greengrass:GetAssociatedRole",
      "greengrass:GetBulkDeploymentStatus",
      "greengrass:GetComponent",
      "greengrass:GetConnectivityInfo",
      "greengrass:GetConnectorDefinitionVersion",
      "greengrass:GetCoreDefinitionVersion",
      "greengrass:GetCoreDevice",
      "greengrass:GetDeployment",
      "greengrass:GetDeploymentStatus",
      "greengrass:GetDeviceDefinitionVersion",
      "greengrass:GetFunctionDefinitionVersion",
      "greengrass:GetGroupCertificateAuthority",
      "greengrass:GetGroupCertificateConfiguration",
      "greengrass:GetGroupVersion",
      "greengrass:GetLoggerDefinitionVersion",
      "greengrass:GetResourceDefinitionVersion",
      "greengrass:GetServiceRoleForAccount",
      "greengrass:GetServiceRoleForAccount",
      "greengrass:GetSubscriptionDefinitionVersion",
    ]
    resources = ["*"]
  }
}
# New permission incoming for 22.0.0 release contain 5 new services:
# https://lacework.atlassian.net/browse/RAIN-95426
data "aws_iam_policy_document" "lacework_audit_policy_2025_4" {
  count = var.use_existing_iam_role_policy ? 0 : 1

  statement {
    sid = "SSM"
    actions = [
      "ssm:GetConnectionStatus",
      "ssm:GetDocument",
      "ssm:GetInventory",
      "ssm:GetMaintenanceWindowExecutionTask",
      "ssm:GetMaintenanceWindowTask",
      "ssm:GetOpsItem",
      "ssm:GetOpsMetadata",
      "ssm:GetParameter",
      "ssm:GetParameterHistory",
      "ssm:GetPatchBaseline",
      "ssm:GetPatchBaselineForPatchGroup",
      "ssm:GetResourcePolicies",
      "ssm:ListCommandInvocations",
      "ssm:ListOpsItemEvents",
      "ssm:ListOpsItemRelatedItems",
    ]
    resources = ["*"]
  }

  statement {
    sid = "EKS"
    actions = [
      "eks:DescribeAddon",
      "eks:ListAddons",
    ]
    resources = ["*"]
  }

  statement {
    sid = "INSPECTOR2"
    actions = [
      "inspector2:BatchGetCodeSnippet",
      "inspector2:BatchGetFindingDetails",
      "inspector2:GetCisScanReport",
      "inspector2:GetCisScanResultDetails",
      "inspector2:GetEncryptionKey",
      "inspector2:ListCisScanConfigurations",
      "inspector2:ListCisScanResultsAggregatedByChecks",
      "inspector2:ListCisScanResultsAggregatedByTargetResource",
      "inspector2:ListCisScans",
      "inspector2:ListMembers",
    ]
    resources = ["*"]
  }

  statement {
    sid = "WAF"
    actions = [
      "waf:GetByteMatchSet",
      "waf:GetGeoMatchSet",
      "waf:GetIPSet",
      "waf:GetLoggingConfiguration",
      "waf:GetPermissionPolicy",
      "waf:GetRateBasedRule",
      "waf:GetRateBasedRuleManagedKeys",
      "waf:GetRegexMatchSet",
      "waf:GetRegexPatternSet",
      "waf:GetRule",
      "waf:GetRuleGroup",
      "waf:GetSizeConstraintSet",
      "waf:GetSqlInjectionMatchSet",
      "waf:GetXssMatchSet",
      "waf:ListActivatedRulesInRuleGroup",
      "waf:ListByteMatchSets",
      "waf:ListGeoMatchSets",
      "waf:ListIPSets",
      "waf:ListLoggingConfigurations",
      "waf:ListRateBasedRules",
      "waf:ListRegexMatchSets",
      "waf:ListRegexPatternSets",
      "waf:ListRuleGroups",
      "waf:ListRules",
      "waf:ListSizeConstraintSets",
      "waf:ListSqlInjectionMatchSets",
      "waf:ListXssMatchSets",
    ]
    resources = ["*"]
  }

  statement {
    sid = "WAFV2"
    actions = [
      "wafv2:GetIPSet",
      "wafv2:GetManagedRuleSet",
      "wafv2:GetPermissionPolicy",
      "wafv2:GetRegexPatternSet",
      "wafv2:GetRuleGroup",
      "wafv2:ListIPSets",
      "wafv2:ListManagedRuleSets",
    ]
    resources = ["*"]
  }

  statement {
    sid       = "APPRUNNER"
    actions   = ["apprunner:ListServicesForAutoScalingConfiguration"]
    resources = ["*"]
  }

  statement {
    sid       = "APPSYNC"
    actions   = ["appsync:GetApiAssociation"]
    resources = ["*"]
  }

  statement {
    sid = "ATHENA"
    actions = [
      "athena:GetCalculationExecution",
      "athena:GetCalculationExecutionCode",
      "athena:GetCalculationExecutionStatus",
      "athena:GetDataCatalog",
      "athena:GetNamedQuery",
      "athena:GetPreparedStatement",
      "athena:GetQueryExecution",
      "athena:GetQueryResults",
      "athena:GetQueryRuntimeStatistics",
      "athena:GetSession",
      "athena:GetSessionStatus",
    ]
    resources = ["*"]
  }

  statement {
    sid = "CE"
    actions = [
      "ce:DescribeCostCategoryDefinition",
      "ce:GetAnomalyMonitors",
      "ce:GetAnomalySubscriptions",
      "ce:GetCommitmentPurchaseAnalysis",
      "ce:ListCommitmentPurchaseAnalyses",
      "ce:ListCostAllocationTagBackfillHistory",
      "ce:ListCostAllocationTags",
      "ce:ListCostCategoryDefinitions",
      "ce:ListTagsForResource",
    ]
    resources = ["*"]
  }

  statement {
    sid = "CLOUDFORMATION"
    actions = [
      "cloudformation:DescribeAccountLimits",
      "cloudformation:DescribeChangeSet",
      "cloudformation:DescribeChangeSetHooks",
      "cloudformation:DescribePublisher",
      "cloudformation:DescribeType",
      "cloudformation:DescribeTypeRegistration",
      "cloudformation:DetectStackDrift",
      "cloudformation:DetectStackSetDrift",
      "cloudformation:GetTemplateSummary",
      "cloudformation:ListChangeSets",
      "cloudformation:ListExports",
      "cloudformation:ListImports",
      "cloudformation:ListTypeRegistrations",
      "cloudformation:ListTypeVersions",
      "cloudformation:ListTypes",
    ]
    resources = ["*"]
  }

  statement {
    sid = "ELASTICBEANSTALK"
    actions = [
      "elasticbeanstalk:ListAvailableSolutionStacks",
      "elasticbeanstalk:ListPlatformBranches",
      "elasticbeanstalk:ListPlatformVersions",
      "elasticbeanstalk:RetrieveEnvironmentInfo",
    ]
    resources = ["*"]
  }

  statement {
    sid = "MEDIATAILOR"
    actions = [
      "mediatailor:DescribeChannel",
      "mediatailor:DescribeLiveSource",
      "mediatailor:DescribeProgram",
      "mediatailor:DescribeSourceLocation",
      "mediatailor:DescribeVodSource",
      "mediatailor:GetChannelPolicy",
      "mediatailor:GetChannelSchedule",
      "mediatailor:GetPlaybackConfiguration",
      "mediatailor:GetPrefetchSchedule",
      "mediatailor:ListAlerts",
      "mediatailor:ListChannels",
      "mediatailor:ListLiveSources",
      "mediatailor:ListPlaybackConfigurations",
      "mediatailor:ListPrefetchSchedules",
      "mediatailor:ListSourceLocations",
      "mediatailor:ListVodSources",
    ]
    resources = ["*"]
  }

  statement {
    sid = "NETWORKFIREWALL"
    actions = [
      "network-firewall:DescribeRuleGroupMetadata",
      "network-firewall:ListTagsForResource",
    ]
    resources = ["*"]
  }

  statement {
    sid = "RESOURCEEXPLORER2"
    actions = [
      "resource-explorer-2:GetAccountLevelServiceConfiguration",
      "resource-explorer-2:GetDefaultView",
      "resource-explorer-2:GetIndex",
      "resource-explorer-2:GetManagedView",
      "resource-explorer-2:GetView",
      "resource-explorer-2:ListIndexes",
      "resource-explorer-2:ListManagedViews",
      "resource-explorer-2:ListSupportedResourceTypes",
      "resource-explorer-2:ListTagsForResource",
      "resource-explorer-2:ListViews",
      "resource-explorer-2:Search",
    ]
    resources = ["*"]
  }

  statement {
    sid = "ROUTE53DOMAINS"
    actions = [
      "route53domains:CheckDomainAvailability",
      "route53domains:CheckDomainTransferability",
      "route53domains:ListPrices",
      "route53domains:ViewBilling",
    ]
    resources = ["*"]
  }

  statement {
    sid = "SERVICEDISCOVERY"
    actions = [
      "servicediscovery:GetInstance",
      "servicediscovery:GetNamespace",
      "servicediscovery:GetOperation",
      "servicediscovery:GetService",
      "servicediscovery:GetServiceAttributes",
      "servicediscovery:ListInstances",
      "servicediscovery:ListNamespaces",
      "servicediscovery:ListOperations",
      "servicediscovery:ListServices",
      "servicediscovery:ListTagsForResource",
    ]
    resources = ["*"]
  }
}

# New permission incoming for 23.0.0 release
# https://lacework.atlassian.net/browse/RAIN-95426
data "aws_iam_policy_document" "lacework_audit_policy_2025_5" {
  count = var.use_existing_iam_role_policy ? 0 : 1

  statement {
    sid = "FORECAST"
    actions = [
      "forecast:DescribeAutoPredictor",
      "forecast:DescribeDataset",
      "forecast:DescribeDatasetGroup",
      "forecast:DescribeDatasetImportJob",
      "forecast:DescribeExplainability",
      "forecast:DescribeExplainabilityExport",
      "forecast:DescribeForecast",
      "forecast:DescribeForecastExportJob",
      "forecast:DescribeMonitor",
      "forecast:DescribePredictor",
      "forecast:DescribePredictorBacktestExportJob",
      "forecast:DescribeWhatIfAnalysis",
      "forecast:DescribeWhatIfForecast",
      "forecast:DescribeWhatIfForecastExport",
      "forecast:GetAccuracyMetrics",
      "forecast:ListDatasetGroups",
      "forecast:ListDatasetImportJobs",
      "forecast:ListExplainabilities",
      "forecast:ListExplainabilityExports",
      "forecast:ListForecastExportJobs",
      "forecast:ListForecasts",
      "forecast:ListMonitorEvaluations",
      "forecast:ListMonitors",
      "forecast:ListPredictorBacktestExportJobs",
      "forecast:ListPredictors",
      "forecast:ListTagsForResource",
      "forecast:ListWhatIfAnalyses",
      "forecast:ListWhatIfForecastExports",
      "forecast:ListWhatIfForecasts",
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "lacework_audit_policy" {
  count = var.use_existing_iam_role_policy ? 0 : 1

  name        = local.lacework_audit_policy_name
  description = "An audit policy to allow Lacework to read configs (extends SecurityAudit)"
  policy      = data.aws_iam_policy_document.lacework_audit_policy[0].json
  tags        = var.tags
}

resource "aws_iam_policy" "lacework_audit_policy_2025_1" {
  count = var.use_existing_iam_role_policy ? 0 : 1

  name        = local.lacework_audit_policy_name_2025_1
  description = "An audit policy to allow Lacework to read configs (extends SecurityAudit), this is the second policy"
  policy      = data.aws_iam_policy_document.lacework_audit_policy_2025_1[0].json
  tags        = var.tags
}

resource "aws_iam_policy" "lacework_audit_policy_2025_2" {
  count = var.use_existing_iam_role_policy ? 0 : 1

  name        = local.lacework_audit_policy_name_2025_2
  description = "An audit policy to allow Lacework to read configs (extends SecurityAudit), this is the third policy"
  policy      = data.aws_iam_policy_document.lacework_audit_policy_2025_2[0].json
  tags        = var.tags
}

resource "aws_iam_policy" "lacework_audit_policy_2025_3" {
  count = var.use_existing_iam_role_policy ? 0 : 1

  name        = local.lacework_audit_policy_name_2025_3
  description = "An audit policy to allow Lacework to read configs (extends SecurityAudit), this is the fourth policy"
  policy      = data.aws_iam_policy_document.lacework_audit_policy_2025_3[0].json
  tags        = var.tags
}

resource "aws_iam_policy" "lacework_audit_policy_2025_4" {
  count = var.use_existing_iam_role_policy ? 0 : 1

  name        = local.lacework_audit_policy_name_2025_4
  description = "An audit policy to allow Lacework to read configs (extends SecurityAudit), this is the fourth policy"
  policy      = data.aws_iam_policy_document.lacework_audit_policy_2025_4[0].json
  tags        = var.tags
}

resource "aws_iam_policy" "lacework_audit_policy_2025_5" {
  count = var.use_existing_iam_role_policy ? 0 : 1

  name        = local.lacework_audit_policy_name_2025_5
  description = "An audit policy to allow Lacework to read configs (extends SecurityAudit), this is the fourth policy"
  policy      = data.aws_iam_policy_document.lacework_audit_policy_2025_5[0].json
  tags        = var.tags
}

resource "aws_iam_role_policy_attachment" "lacework_audit_policy_attachment" {
  count = var.use_existing_iam_role_policy ? 0 : 1

  role       = local.iam_role_name
  policy_arn = aws_iam_policy.lacework_audit_policy[0].arn
  depends_on = [module.lacework_cfg_iam_role]
}

resource "aws_iam_role_policy_attachment" "lacework_audit_policy_attachment_b" {
  count = var.use_existing_iam_role_policy ? 0 : 1

  role       = local.iam_role_name
  policy_arn = aws_iam_policy.lacework_audit_policy_2025_1[0].arn
  depends_on = [module.lacework_cfg_iam_role]
}

resource "aws_iam_role_policy_attachment" "lacework_audit_policy_attachment_c" {
  count = var.use_existing_iam_role_policy ? 0 : 1

  role       = local.iam_role_name
  policy_arn = aws_iam_policy.lacework_audit_policy_2025_2[0].arn
  depends_on = [module.lacework_cfg_iam_role]
}

resource "aws_iam_role_policy_attachment" "lacework_audit_policy_attachment_d" {
  count = var.use_existing_iam_role_policy ? 0 : 1

  role       = local.iam_role_name
  policy_arn = aws_iam_policy.lacework_audit_policy_2025_3[0].arn
  depends_on = [module.lacework_cfg_iam_role]
}

resource "aws_iam_role_policy_attachment" "lacework_audit_policy_attachment_e" {
  count = var.use_existing_iam_role_policy ? 0 : 1

  role       = local.iam_role_name
  policy_arn = aws_iam_policy.lacework_audit_policy_2025_4[0].arn
  depends_on = [module.lacework_cfg_iam_role]
}

resource "aws_iam_role_policy_attachment" "lacework_audit_policy_attachment_f" {
  count = var.use_existing_iam_role_policy ? 0 : 1

  role       = local.iam_role_name
  policy_arn = aws_iam_policy.lacework_audit_policy_2025_5[0].arn
  depends_on = [module.lacework_cfg_iam_role]
}

# wait for X seconds for things to settle down in the AWS side
# before trying to create the Lacework external integration
resource "time_sleep" "wait_time" {
  create_duration = var.wait_time
  depends_on = [
    aws_iam_role_policy_attachment.security_audit_policy_attachment,
    aws_iam_role_policy_attachment.lacework_audit_policy_attachment,
    aws_iam_role_policy_attachment.lacework_audit_policy_attachment_b,
    aws_iam_role_policy_attachment.lacework_audit_policy_attachment_c,
    aws_iam_role_policy_attachment.lacework_audit_policy_attachment_d,
    aws_iam_role_policy_attachment.lacework_audit_policy_attachment_e,
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
