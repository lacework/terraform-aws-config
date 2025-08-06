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
  version_file   = "${abspath(path.module)}/VERSION"
  module_name    = "terraform-aws-config"
  module_version = fileexists(local.version_file) ? file(local.version_file) : ""
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
    sid       = "GetBucketPublicAccessBlock"
    actions   = ["s3:GetBucketPublicAccessBlock"]
    resources = ["*"]
  }

  statement {
    sid = "EFS"
    actions = ["elasticfilesystem:ListTagsForResource"]
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
    "identitystore:DescribeUser"]
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
    actions = ["apigateway:GET"]
    resources = ["arn:aws:apigateway:*::/apikeys",
    "arn:aws:apigateway:*::/apikeys/*",
    "arn:aws:apigateway:*::/domainnames/*",
    "arn:aws:apigateway:*::/domainnames/*/basepathmappings",
    "arn:aws:apigateway:*::/domainnames/*/basepathmappings/*",
    "arn:aws:apigateway:*::/usageplans",
    "arn:aws:apigateway:*::/usageplans/*",
    "arn:aws:apigateway:*::/sdktypes",
    "arn:aws:apigateway:*::/sdktypes/*"
    ]
  }

  statement {
    sid = "GLACIER"
    actions = ["glacier:ListTagsForVault"]
    resources = ["*"]
  }

  statement {
    sid = "WAFREGIONAL"
    actions = ["waf-regional:ListRules",
      "waf-regional:GetRule",
      "waf-regional:ListRuleGroups",
      "waf-regional:GetRuleGroup",
      "waf-regional:ListActivatedRulesInRuleGroup",
      "waf-regional:GetByteMatchSet",
      "waf-regional:GetPermissionPolicy",
      "waf-regional:GetRateBasedRule",
      "waf-regional:ListSizeConstraintSets",
      "waf-regional:ListByteMatchSets",
      "waf-regional:ListGeoMatchSets",
      "waf-regional:GetLoggingConfiguration",
      "waf-regional:GetSqlInjectionMatchSet",
      "waf-regional:ListRateBasedRules",
      "waf-regional:GetSizeConstraintSet",
      "waf-regional:GetRegexMatchSet",
      "waf-regional:GetGeoMatchSet",
      "waf-regional:GetRegexPatternSet",
      "waf-regional:ListRegexMatchSets",
      "waf-regional:GetIPSet",
      "waf-regional:ListSqlInjectionMatchSets",
      "waf-regional:ListXssMatchSets",
      "waf-regional:GetXssMatchSet"]
     resources = ["*"]
  }

  statement {
    sid = "GLUE"
    actions = ["glue:ListWorkflows",
      "glue:BatchGetWorkflows",
      "glue:GetWorkflow"]
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

  statement {
    sid = "STATES"
    actions = ["states:ListTagsForResource"]
    resources = ["*"]
  }

  statement {
    sid = "SES"
    actions = ["ses:ListContactLists",
      "ses:GetContactList",
      "ses:ListContacts",
      "ses:GetContact",
      "ses:ListCustomVerificationEmailTemplates",
      "ses:GetCustomVerificationEmailTemplate",
      "ses:GetDedicatedIpPool",
      "ses:ListDeliverabilityTestReports",
      "ses:GetDeliverabilityTestReport",
      "ses:ListEmailIdentities",
      "ses:GetEmailIdentity",
      "ses:GetEmailIdentityPolicies",
      "ses:ListEmailTemplates",
      "ses:GetEmailTemplate",
      "ses:ListImportJobs",
      "ses:GetImportJob",
      "ses:ListRecommendations",
      "ses:ListSuppressedDestinations",
      "ses:GetSuppressedDestination",
      "ses:ListTagsForResource",
    ]
    resources = ["*"]
  }

  statement {
    sid = "BACKUP"
    actions = ["backup:ListBackupJobs",
      "backup:DescribeBackupJob",
      "backup:ListBackupPlanTemplates",
      "backup:GetBackupPlanFromTemplate",
      "backup:ListBackupPlans",
      "backup:GetBackupPlan",
      "backup:ListBackupPlanVersions",
      "backup:ListBackupSelections",
      "backup:GetBackupSelection",
      "backup:DescribeBackupVault",
      "backup:ListRecoveryPointsByBackupVault",
      "backup:DescribeRecoveryPoint",
      "backup:GetRecoveryPointRestoreMetadata",
      "backup:ListCopyJobs",
      "backup:ListFrameworks",
      "backup:DescribeFramework",
      "backup:ListLegalHolds",
      "backup:GetLegalHold",
      "backup:ListRecoveryPointsByLegalHold",
      "backup:ListProtectedResources",
      "backup:DescribeProtectedResource",
      "backup:ListRecoveryPointsByResource",
      "backup:ListReportPlans",
      "backup:ListRestoreJobs",
    ]
    resources = ["*"]
  }

  statement {
    sid = "COGNITOIDP"
    actions = ["cognito-idp:GetSigningCertificate",
      "cognito-idp:GetCSVHeader",
      "cognito-idp:GetUserPoolMfaConfig",
      "cognito-idp:GetUICustomization",
    ]
    resources = ["*"]
  }

  statement {
    sid       = "COMPUTEOPTIMIZER"
    actions   = [
      "compute-optimizer:DescribeRecommendationExportJobs",
      "compute-optimizer:GetAutoScalingGroupRecommendations",
      "compute-optimizer:GetEffectiveRecommendationPreferences",
      "compute-optimizer:GetEBSVolumeRecommendations",
      "compute-optimizer:GetEC2InstanceRecommendations",
      "compute-optimizer:GetEnrollmentStatus",
      "compute-optimizer:GetLambdaFunctionRecommendations",
      "compute-optimizer:GetRecommendationPreferences",
      "compute-optimizer:GetRecommendationSummaries",
      "compute-optimizer:GetEcsServiceRecommendations",
      "compute-optimizer:GetLicenseRecommendations",
    ]
    resources = ["*"]
  }

  statement {
    sid = "KINESISANALYTICS"
    actions = ["kinesisanalytics:ListApplicationSnapshots",
      "kinesisanalytics:ListApplicationVersions",
      "kinesisanalytics:DescribeApplicationVersion",
      "kinesisanalytics:DescribeApplication",
    ]
    resources = ["*"]
  }

  statement {
    sid = "KINESISVIDEO"
    actions = ["kinesisvideo:GetSignalingChannelEndpoint",
      "kinesisvideo:GetDataEndpoint",
      "kinesisvideo:DescribeImageGenerationConfiguration",
    ]
    resources = ["*"]
  }

  statement {
    sid = "AMP"
    actions = ["aps:ListScrapers",
      "aps:DescribeScraper",
      "aps:ListWorkspaces",
      "aps:DescribeAlertManagerDefinition",
      "aps:DescribeLoggingConfiguration",
      "aps:DescribeWorkspace",
      "aps:ListRuleGroupsNamespaces",
      "aps:DescribeRuleGroupsNamespace",
      "aps:ListTagsForResource",
    ]
    resources = ["*"]
  }
}

# AWS iam allows only 6144 characters in a single policy
# We've come to a point where there are too many actions in a single policy which is causing the policy to exceed the limit
# So we needed a new policy to accommodate the overflow of actions, thus we added this new policy "lacework_audit_policy_2025_1"
# Which representing the first new policy in 2025
data "aws_iam_policy_document" "lacework_audit_policy_2025_1" {
  count   = var.use_existing_iam_role_policy ? 0 : 1
  version = "2012-10-17"

  statement {
    sid = "APPSTREAM"
    actions = ["appstream:Describe*",
      "appstream:List*",
    ]
    resources = ["*"]
  }

  statement {
    sid = "PERSONALIZE"
    actions = ["personalize:Describe*",
      "personalize:List*",
      "personalize:GetSolutionMetrics",
    ]
    resources = ["*"]
  }

  statement {
    sid = "CODEARTIFACT"
    actions = ["codeartifact:ListDomains",
      "codeartifact:DescribeDomain",
      "codeartifact:DescribeRepository",
      "codeartifact:ListPackages",
      "codeartifact:GetRepositoryEndpoint",
      "codeartifact:DescribePackage",
      "codeartifact:ListPackageVersions",
      "codeartifact:DescribePackageVersion",
      "codeartifact:GetPackageVersionReadme",
      "codeartifact:ListPackageVersionDependencies",
      "codeartifact:ListPackageVersionAssets",
      "codeartifact:GetPackageVersionAsset",
      "codeartifact:ListTagsForResource",
    ]
    resources = ["*"]
  }

  statement {
    sid = "FIS"
    actions = ["fis:ListActions",
        "fis:GetAction",
        "fis:ListExperimentTemplates",
        "fis:GetExperimentTemplate",
        "fis:ListTargetAccountConfigurations",
        "fis:ListExperiments",
        "fis:GetExperiment",
        "fis:ListExperimentResolvedTargets",
        "fis:ListTagsForResource",
    ]
    resources = ["*"]
  }

  statement {
    sid = "MEMORYDB"
    actions = ["memorydb:DescribeMultiRegionClusters",
      "memorydb:DescribeSnapshots",
      "memorydb:DescribeSubnetGroups",
      "memorydb:DescribeParameterGroups",
      "memorydb:DescribeParameters",
      "memorydb:DescribeUsers",
      "memorydb:DescribeACLs",
      "memorydb:DescribeServiceUpdates",
      "memorydb:DescribeEngineVersions",
      "memorydb:DescribeReservedNodes",
      "memorydb:DescribeReservedNodesOfferings",
      "memorydb:ListTags",
      "memorydb:ListAllowedNodeTypeUpdates",
      "memorydb:ListAllowedMultiRegionClusterUpdates",
    ]
    resources = ["*"]
  }

  statement {
    sid = "QBUSINESS"
    actions = ["qbusiness:GetApplication",
      "qbusiness:GetChatControlsConfiguration",
      "qbusiness:GetPolicy",
      "qbusiness:ListAttachments",
      "qbusiness:ListConversations",
      "qbusiness:ListMessages",
      "qbusiness:ListDataAccessors",
      "qbusiness:GetDataAccessor",
      "qbusiness:GetIndex",
      "qbusiness:GetDataSource",
      "qbusiness:GetPlugin",
      "qbusiness:ListPluginActions",
      "qbusiness:GetRetriever",
      "qbusiness:GetWebExperience",
      "qbusiness:ListPluginTypeMetadata",
      "qbusiness:ListPluginTypeActions",
    ]
    resources = ["*"]
  }

  statement {
    sid = "QAPPS"
    actions = ["qapps:DescribeQAppPermissions",
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
    actions = ["wisdom:GetAIAgent",
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
      "wisdom:ListTagsForResource"
    ]
    resources = ["*"]
  }

  statement {
    sid = "RESOURCEGROUPS"
    actions = ["resource-groups:ListGroups",
      "resource-groups:GetGroupQuery",
      "resource-groups:GetGroupConfiguration",
    ]
    resources = ["*"]
  }

  statement {
    sid = "SERVICECATALOGAPPREGISTRY"
    actions = ["servicecatalog:GetApplication",
      "servicecatalog:ListApplications",
      "servicecatalog:GetAssociatedResource",
      "servicecatalog:ListAssociatedResources",
      "servicecatalog:ListAssociatedAttributeGroups",
      "servicecatalog:GetAttributeGroup",
      "servicecatalog:ListAttributeGroups",
      "servicecatalog:ListTagsForResource",
      "servicecatalog:ListAttributeGroupsForApplication",
      "servicecatalog:GetConfiguration"
    ]
    resources = ["*"]
  }

  statement {
    sid = "OAM"
    actions = ["oam:GetLink",
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
    actions = ["clouddirectory:GetAppliedSchemaVersion",
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
    actions = ["cost-optimization-hub:GetPreferences",
      "cost-optimization-hub:GetRecommendation",
      "cost-optimization-hub:ListEnrollmentStatuses",
      "cost-optimization-hub:ListRecommendationSummaries",
      "cost-optimization-hub:ListRecommendations",
    ]
    resources = ["*"]
  }

  statement {
    sid = "BUDGETS"
    actions = ["budgets:DescribeBudgetAction",
      "budgets:DescribeBudgetActionHistories",
      "budgets:DescribeBudgetActionsForAccount",
      "budgets:DescribeBudgetActionsForBudget",
      "budgets:ListTagsForResource",
      "budgets:ViewBudget",
    ]
    resources = ["*"]
  }

  statement {
    sid = "BILLINGCONSOLE"
    actions = ["aws-portal:GetConsoleActionSetEnforced",
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
  count   = var.use_existing_iam_role_policy ? 0 : 1
  version = "2012-10-17"

  statement {
    sid = "FREETIER"
    actions = ["freetier:GetFreeTierUsage"]
    resources = ["*"]
  }

  statement {
    sid = "ACMPCA"
    actions = ["acm-pca:GetCertificateAuthorityCertificate",
      "acm-pca:GetCertificateAuthorityCsr",
    ]
    resources = ["*"]
  }

  statement {
    sid = "APPCONFIG"
    actions = ["appconfig:GetConfigurationProfile",
      "appconfig:GetDeploymentStrategy",
      "appconfig:GetExtension",
      "appconfig:GetExtensionAssociation",
      "appconfig:GetHostedConfigurationVersion",
      "appconfig:ListApplications",
      "appconfig:ListConfigurationProfiles",
      "appconfig:ListDeployments",
      "appconfig:ListDeploymentStrategies",
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
    actions = ["appflow:DescribeConnectorEntity",
      "appflow:DescribeConnectorProfiles",
      "appflow:DescribeConnectors",
      "appflow:DescribeFlow",
      "appflow:DescribeFlowExecutionRecords",
      "appflow:ListConnectorEntities",
      "appflow:ListConnectors",
    ]
    resources = ["*"]
  }

  statement {
    sid = "DYNAMODB"
    actions = ["dynamodb:GetResourcePolicy",
      "dynamodb:DescribeContributorInsights",
    ]
    resources = ["*"]
  }

  statement {
    sid = "EBS"
    actions = ["ebs:GetSnapshotBlock",
      "ebs:ListSnapshotBlocks",
    ]
    resources = ["*"]
  }

  statement {
    sid = "LAKEFORMATION"
    actions = ["lakeformation:DescribeLakeFormationIdentityCenterConfiguration",
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
    actions = ["lambda:GetFunction",
      "lambda:GetFunctionCodeSigningConfig",
    ]
    resources = ["*"]
  }

  statement {
    sid = "SCHEDULER"
    actions = ["scheduler:GetSchedule",
      "scheduler:GetScheduleGroup",
      "scheduler:ListScheduleGroups",
      "scheduler:ListSchedules",
      "scheduler:ListTagsForResource",
    ]
    resources = ["*"]
  }

  statement {
    sid = "SCHEMAS"
    actions = ["schemas:GetCodeBindingSource"]
    resources = ["*"]
  }

  statement {
    sid = "DATASYNC"
    actions = ["datasync:DescribeTaskExecution",
      "datasync:DescribeLocationEfs",
      "datasync:ListAgents",
      "datasync:ListLocations",
      "datasync:ListTaskExecutions",
      "datasync:ListStorageSystems",
      "datasync:DescribeLocationSmb",
      "datasync:DescribeAgent",
      "datasync:DescribeLocationFsxWindows",
      "datasync:DescribeTask",
      "datasync:DescribeLocationS3",
      "datasync:DescribeDiscoveryJob",
      "datasync:DescribeLocationObjectStorage",
      "datasync:DescribeStorageSystem",
      "datasync:DescribeLocationAzureBlob",
      "datasync:ListTagsForResource",
      "datasync:ListTasks",
      "datasync:DescribeLocationHdfs",
      "datasync:DescribeLocationFsxLustre",
      "datasync:ListDiscoveryJobs",
      "datasync:DescribeLocationNfs"
    ]
    resources = ["*"]
  }
}

# New permission incoming for 21.0.0 release contain 13 new services:
# https://lacework.atlassian.net/browse/RAIN-95014
data "aws_iam_policy_document" "lacework_audit_policy_2025_3" {
  count   = var.use_existing_iam_role_policy ? 0 : 1
  version = "2012-10-17"

  statement {
    sid = "IOT"
    actions = ["iot:GetCommand",
      "iot:GetCommandExecution",
      "iot:GetEffectivePolicies",
      "iot:GetIndexingConfiguration",
      "iot:GetJobDocument",
      "iot:GetV2LoggingOptions",
      "iot:GetOtaUpdate",
      "iot:GetPackage",
      "iot:GetPackageConfiguration",
      "iot:GetPackageVersion",
      "iot:GetRegistrationCode",
      "iot:GetBehaviorModelTrainingSummaries",
      "iot:GetThingConnectivityData",
      "iot:GetTopicRule",
      "iot:GetTopicRuleDestination",
    ]
    resources = ["*"]
  }

  statement {
    sid = "IOTEVENTS"
    actions = ["iotevents:DescribeAlarmModel",
      "iotevents:ListAlarmModels",
      "iotevents:ListTagsForResource",
      "iotevents:ListAlarmModelVersions",
      "iotevents:DescribeDetectorModel",
      "iotevents:ListDetectorModels",
      "iotevents:ListDetectorModelVersions",
      "iotevents:DescribeInput",
      "iotevents:DescribeLoggingOptions",
    ]
    resources = ["*"]
  }

  statement {
    sid = "MEDIAPACKAGE"
    actions = ["mediapackage:ListChannels",
      "mediapackage:ListHarvestJobs",
      "mediapackage:ListTagsForResource",
    ]
    resources = ["*"]
  }

  statement {
    sid = "MEDIAPACKAGEV2"
    actions = ["mediapackagev2:GetChannel",
      "mediapackagev2:GetChannelPolicy",
      "mediapackagev2:ListChannels",
      "mediapackagev2:ListTagsForResource",
      "mediapackagev2:GetChannelGroup",
      "mediapackagev2:ListChannelGroups",
      "mediapackagev2:ListHarvestJobs",
      "mediapackagev2:GetOriginEndpoint",
      "mediapackagev2:GetOriginEndpointPolicy",
      "mediapackagev2:ListOriginEndpoints",
    ]
    resources = ["*"]
  }

  statement {
    sid = "MEDIAPACKAGEVOD"
    actions = ["mediapackage-vod:DescribeAsset",
      "mediapackage-vod:ListAssets",
      "mediapackage-vod:ListPackagingConfigurations",
      "mediapackage-vod:ListPackagingGroups",
    ]
    resources = ["*"]
  }

  statement {
    sid = "SUPPORT"
    actions = ["support:DescribeCases",
      "support:DescribeCommunications",
      "support:DescribeServices",
      "support:DescribeSeverityLevels",
    ]
    resources = ["*"]
  }

  statement {
    sid = "IMAGEBUILDER"
    actions = ["imagebuilder:GetComponentPolicy",
      "imagebuilder:ListComponents",
      "imagebuilder:ListTagsForResource",
      "imagebuilder:GetComponent",
      "imagebuilder:ListComponentBuildVersions",
      "imagebuilder:GetContainerRecipe",
      "imagebuilder:GetContainerRecipePolicy",
      "imagebuilder:ListContainerRecipes",
      "imagebuilder:GetDistributionConfiguration",
      "imagebuilder:ListDistributionConfigurations",
      "imagebuilder:GetImagePolicy",
      "imagebuilder:ListImages",
      "imagebuilder:GetImage",
      "imagebuilder:ListImageBuildVersions",
      "imagebuilder:ListImagePackages",
      "imagebuilder:GetImagePipeline",
      "imagebuilder:ListImagePipelines",
      "imagebuilder:GetImageRecipe",
      "imagebuilder:GetImageRecipePolicy",
      "imagebuilder:ListImageRecipes",
      "imagebuilder:ListImageScanFindings",
      "imagebuilder:ListImageScanFindingAggregations",
      "imagebuilder:GetInfrastructureConfiguration",
      "imagebuilder:ListInfrastructureConfigurations",
      "imagebuilder:ListLifecycleExecutions",
      "imagebuilder:ListLifecycleExecutionResources",
      "imagebuilder:GetLifecyclePolicy",
      "imagebuilder:ListLifecyclePolicies",
      "imagebuilder:ListWorkflows",
      "imagebuilder:GetWorkflow",
      "imagebuilder:ListWorkflowBuildVersions",
      "imagebuilder:ListWorkflowExecutions",
      "imagebuilder:GetWorkflowStepExecution",
      "imagebuilder:ListWorkflowStepExecutions",
    ]
    resources = ["*"]
  }

  statement {
    sid = "DETECTIVE"
    actions = ["detective:BatchGetMembershipDatasources",
      "detective:ListDatasourcePackages",
      "detective:ListTagsForResource",
      "detective:GetInvestigation",
      "detective:ListIndicators",
      "detective:ListInvestigations",
      "detective:ListInvitations",
      "detective:BatchGetGraphMemberDatasources",
      "detective:ListOrganizationAdminAccounts",
    ]
    resources = ["*"]
  }

  statement {
    sid = "BATCH"
    actions = ["batch:DescribeJobs",
      "batch:ListJobs",
      "batch:ListTagsForResource",
      "batch:DescribeJobQueues",
      "batch:DescribeSchedulingPolicies",
      "batch:ListSchedulingPolicies",
    ]
    resources = ["*"]
  }

  statement {
    sid = "NETWORKMANAGER"
    actions = ["networkmanager:GetConnectAttachment",
      "networkmanager:GetSiteToSiteVpnAttachment",
      "networkmanager:GetTransitGatewayRouteTableAttachment",
      "networkmanager:GetVpcAttachment",
      "networkmanager:ListAttachments",
      "networkmanager:GetConnectPeer",
      "networkmanager:ListConnectPeers",
      "networkmanager:GetCoreNetwork",
      "networkmanager:GetCoreNetworkChangeEvents",
      "networkmanager:GetCoreNetworkChangeSet",
      "networkmanager:GetCoreNetworkPolicy",
      "networkmanager:GetNetworkRoutes",
      "networkmanager:ListCoreNetworkPolicyVersions",
      "networkmanager:ListCoreNetworks",
      "networkmanager:GetConnectPeerAssociations",
      "networkmanager:GetConnections",
      "networkmanager:GetCustomerGatewayAssociations",
      "networkmanager:GetDevices",
      "networkmanager:GetLinkAssociations",
      "networkmanager:GetLinks",
      "networkmanager:GetNetworkResourceCounts",
      "networkmanager:GetNetworkResourceRelationships",
      "networkmanager:GetNetworkResources",
      "networkmanager:GetNetworkTelemetry",
      "networkmanager:GetResourcePolicy",
      "networkmanager:GetSites",
      "networkmanager:GetTransitGatewayConnectPeerAssociations",
      "networkmanager:GetTransitGatewayRegistrations",
      "networkmanager:GetTransitGatewayPeering",
      "networkmanager:ListPeerings",
    ]
    resources = ["*"]
  }

  statement {
    sid = "CODEPIPELINE"
    actions = ["codepipeline:ListActionExecutions",
      "codepipeline:GetActionType",
      "codepipeline:ListActionTypes",
      "codepipeline:ListTagsForResource",
      "codepipeline:ListPipelineExecutions",
      "codepipeline:ListRuleExecutions",
      "codepipeline:ListRuleTypes",
      "codepipeline:ListWebhooks",
    ]
    resources = ["*"]
  }

  statement {
    sid = "GREENGRASS"
    actions = ["greengrass:GetBulkDeploymentStatus",
      "greengrass:GetGroupCertificateAuthority",
      "greengrass:GetConnectorDefinitionVersion",
      "greengrass:GetCoreDefinitionVersion",
      "greengrass:GetDeploymentStatus",
      "greengrass:GetDeviceDefinitionVersion",
      "greengrass:GetFunctionDefinitionVersion",
      "greengrass:GetAssociatedRole",
      "greengrass:GetGroupCertificateConfiguration",
      "greengrass:GetGroupVersion",
      "greengrass:GetLoggerDefinitionVersion",
      "greengrass:GetResourceDefinitionVersion",
      "greengrass:GetServiceRoleForAccount",
      "greengrass:GetSubscriptionDefinitionVersion",
      "greengrass:DescribeComponent",
      "greengrass:GetComponent",
      "greengrass:GetConnectivityInfo",
      "greengrass:GetCoreDevice",
      "greengrass:GetDeployment",
      "greengrass:GetServiceRoleForAccount",
    ]
    resources = ["*"]
  }
}
  # New permission incoming for 22.0.0 release contain 5 new services:
# https://lacework.atlassian.net/browse/RAIN-95426
data "aws_iam_policy_document" "lacework_audit_policy_2025_4" {
  count   = var.use_existing_iam_role_policy ? 0 : 1
  version = "2012-10-17"

  statement {
    sid = "SSM"
    actions = ["ssm:GetConnectionStatus",
    ]
    resources = ["*"]
  }

  statement {
      sid = "EKS"
      actions = ["eks:DescribeAddon",
        "eks:ListAddons",
      ]
      resources = ["*"]
    }

  statement {
    sid = "INSPECTOR2"
    actions = [	"inspector2:BatchGetCodeSnippet",
      "inspector2:ListCisScanResultsAggregatedByChecks",
      "inspector2:ListCisScanResultsAggregatedByTargetResource",
      "inspector2:ListCisScanConfigurations",
      "inspector2:ListMembers",
      "inspector2:BatchGetFindingDetails",
      "inspector2:GetCisScanReport",
      "inspector2:GetCisScanResultDetails",
      "inspector2:ListCisScans",
      "inspector2:GetEncryptionKey",
    ]
    resources = ["*"]
  }

  statement {
    sid = "WAF"
    actions = ["waf:GetRegexPatternSet",
      "waf:GetPermissionPolicy",
      "waf:ListIPSets",
      "waf:GetIPSet",
      "waf:GetRuleGroup"
    ]
     resources = ["*"]
  }

  statement {
    sid = "WAFV2"
    actions = ["wafv2:GetManagedRuleSet",
      "wafv2:GetRegexPatternSet",
      "wafv2:GetPermissionPolicy",
      "wafv2:GetIPSet",
      "wafv2:ListIPSets",
      "wafv2:ListManagedRuleSets",
      "wafv2:GetRuleGroup"
    ]
     resources = ["*"]
  }

  statement {
    sid = "FORECAST"
    actions = ["forecast:DescribeDataset",
      "forecast:GetAccuracyMetrics",
      "forecast:DescribeExplainability",
      "forecast:ListForecastExportJobs",
      "forecast:ListForecasts",
      "forecast:DescribeForecast",
      "forecast:DescribeMonitor",
      "forecast:ListMonitorEvaluations",
      "forecast:DescribePredictor",
      "forecast:ListWhatIfForecasts",
      "forecast:DescribeDatasetImportJob",
      "forecast:ListDatasetGroups",
      "forecast:ListPredictorBacktestExportJobs",
      "forecast:DescribeExplainabilityExport",
      "forecast:ListMonitors",
      "forecast:DescribePredictorBacktestExportJob",
      "forecast:DescribeDatasetGroup",
      "forecast:ListWhatIfAnalyses",
      "forecast:DescribeWhatIfForecastExport",
      "forecast:DescribeAutoPredictor",
      "forecast:ListExplainabilities",
      "forecast:DescribeForecastExportJob",
      "forecast:DescribeWhatIfForecast",
      "forecast:DescribeWhatIfAnalysis",
      "forecast:ListDatasetImportJobs",
      "forecast:ListExplainabilityExports",
      "forecast:ListWhatIfForecastExports",
      "forecast:ListTagsForResource",
      "forecast:ListPredictors"
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

resource "aws_iam_policy" "lacework_audit_policy_2025_1" {
  count       = var.use_existing_iam_role_policy ? 0 : 1
  name        = local.lacework_audit_policy_name_2025_1
  description = "An audit policy to allow Lacework to read configs (extends SecurityAudit), this is the second policy"
  policy      = data.aws_iam_policy_document.lacework_audit_policy_2025_1[0].json
  tags        = var.tags
}

resource "aws_iam_policy" "lacework_audit_policy_2025_2" {
  count       = var.use_existing_iam_role_policy ? 0 : 1
  name        = local.lacework_audit_policy_name_2025_2
  description = "An audit policy to allow Lacework to read configs (extends SecurityAudit), this is the third policy"
  policy      = data.aws_iam_policy_document.lacework_audit_policy_2025_2[0].json
  tags        = var.tags
}

resource "aws_iam_policy" "lacework_audit_policy_2025_3" {
  count       = var.use_existing_iam_role_policy ? 0 : 1
  name        = local.lacework_audit_policy_name_2025_3
  description = "An audit policy to allow Lacework to read configs (extends SecurityAudit), this is the fourth policy"
  policy      = data.aws_iam_policy_document.lacework_audit_policy_2025_3[0].json
  tags        = var.tags
}

resource "aws_iam_policy" "lacework_audit_policy_2025_4" {
  count       = var.use_existing_iam_role_policy ? 0 : 1
  name        = local.lacework_audit_policy_name_2025_4
  description = "An audit policy to allow Lacework to read configs (extends SecurityAudit), this is the fourth policy"
  policy      = data.aws_iam_policy_document.lacework_audit_policy_2025_4[0].json
  tags        = var.tags
}

resource "aws_iam_role_policy_attachment" "lacework_audit_policy_attachment" {
  count      = var.use_existing_iam_role_policy ? 0 : 1
  role       = local.iam_role_name
  policy_arn = aws_iam_policy.lacework_audit_policy[0].arn
  depends_on = [module.lacework_cfg_iam_role]
}

resource "aws_iam_role_policy_attachment" "lacework_audit_policy_attachment_b" {
  count      = var.use_existing_iam_role_policy ? 0 : 1
  role       = local.iam_role_name
  policy_arn = aws_iam_policy.lacework_audit_policy_2025_1[0].arn
  depends_on = [module.lacework_cfg_iam_role]
}

resource "aws_iam_role_policy_attachment" "lacework_audit_policy_attachment_c" {
  count      = var.use_existing_iam_role_policy ? 0 : 1
  role       = local.iam_role_name
  policy_arn = aws_iam_policy.lacework_audit_policy_2025_2[0].arn
  depends_on = [module.lacework_cfg_iam_role]
}

resource "aws_iam_role_policy_attachment" "lacework_audit_policy_attachment_d" {
  count      = var.use_existing_iam_role_policy ? 0 : 1
  role       = local.iam_role_name
  policy_arn = aws_iam_policy.lacework_audit_policy_2025_3[0].arn
  depends_on = [module.lacework_cfg_iam_role]
}

resource "aws_iam_role_policy_attachment" "lacework_audit_policy_attachment_e" {
  count      = var.use_existing_iam_role_policy ? 0 : 1
  role       = local.iam_role_name
  policy_arn = aws_iam_policy.lacework_audit_policy_2025_4[0].arn
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

data "lacework_metric_module" "lwmetrics" {
  name    = local.module_name
  version = local.module_version
}
