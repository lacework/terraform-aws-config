<a href="https://lacework.com"><img src="https://techally-content.s3-us-west-1.amazonaws.com/public-content/lacework_logo_full.png" width="600"></a>

# terraform-aws-config

[![GitHub release](https://img.shields.io/github/release/lacework/terraform-aws-config.svg)](https://github.com/lacework/terraform-aws-config/releases/)
[![Codefresh build status]( https://g.codefresh.io/api/badges/pipeline/lacework/terraform-modules%2Ftest-compatibility?type=cf-1&key=eyJhbGciOiJIUzI1NiJ9.NWVmNTAxOGU4Y2FjOGQzYTkxYjg3ZDEx.RJ3DEzWmBXrJX7m38iExJ_ntGv4_Ip8VTa-an8gBwBo)]( https://g.codefresh.io/pipelines/edit/new/builds?id=607e25e6728f5a6fba30431b&pipeline=test-compatibility&projects=terraform-modules&projectId=607db54b728f5a5f8930405d)

Terraform module for configuring an integration with Lacework and AWS for cloud resource configuration assessment.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.35.0 |
| <a name="requirement_lacework"></a> [lacework](#requirement\_lacework) | ~> 2.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 2.1 |
| <a name="requirement_time"></a> [time](#requirement\_time) | ~> 0.7 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.35.0 |
| <a name="provider_lacework"></a> [lacework](#provider\_lacework) | ~> 2.0 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 2.1 |
| <a name="provider_time"></a> [time](#provider\_time) | ~> 0.7 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_lacework_cfg_iam_role"></a> [lacework\_cfg\_iam\_role](#module\_lacework\_cfg\_iam\_role) | lacework/iam-role/aws | ~> 0.4 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.lacework_audit_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.lacework_audit_policy_2025_1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.lacework_audit_policy_2025_2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.lacework_audit_policy_2025_3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.lacework_audit_policy_2025_4](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role_policy_attachment.lacework_audit_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.lacework_audit_policy_attachment_b](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.lacework_audit_policy_attachment_c](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.lacework_audit_policy_attachment_d](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.lacework_audit_policy_attachment_e](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.security_audit_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [lacework_integration_aws_cfg.default](https://registry.terraform.io/providers/lacework/lacework/latest/docs/resources/integration_aws_cfg) | resource |
| [random_id.uniq](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [time_sleep.wait_time](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [aws_caller_identity.current_aws_account](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.lacework_audit_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.lacework_audit_policy_2025_1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.lacework_audit_policy_2025_2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.lacework_audit_policy_2025_3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.lacework_audit_policy_2025_4](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [lacework_metric_module.lwmetrics](https://registry.terraform.io/providers/lacework/lacework/latest/docs/data-sources/metric_module) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_external_id_length"></a> [external\_id\_length](#input\_external\_id\_length) | **Deprecated** - Will be removed on our next major release v1.0.0 | `number` | `16` | no |
| <a name="input_iam_role_arn"></a> [iam\_role\_arn](#input\_iam\_role\_arn) | The IAM role ARN is required when setting use\_existing\_iam\_role to `true` | `string` | `""` | no |
| <a name="input_iam_role_external_id"></a> [iam\_role\_external\_id](#input\_iam\_role\_external\_id) | The external ID configured inside the IAM role is required when setting use\_existing\_iam\_role to `true` | `string` | `""` | no |
| <a name="input_iam_role_name"></a> [iam\_role\_name](#input\_iam\_role\_name) | The IAM role name. Required to match with iam\_role\_arn if use\_existing\_iam\_role is set to `true` | `string` | `""` | no |
| <a name="input_lacework_audit_policy_name"></a> [lacework\_audit\_policy\_name](#input\_lacework\_audit\_policy\_name) | The name of the custom audit policy (which extends SecurityAudit) to allow Lacework to read configs.  Defaults to lwaudit-policy-${random\_id.uniq.hex} when empty | `string` | `""` | no |
| <a name="input_lacework_aws_account_id"></a> [lacework\_aws\_account\_id](#input\_lacework\_aws\_account\_id) | The Lacework AWS account that the IAM role will grant access | `string` | `"434813966438"` | no |
| <a name="input_lacework_integration_name"></a> [lacework\_integration\_name](#input\_lacework\_integration\_name) | The name of the integration in Lacework | `string` | `"TF config"` | no |
| <a name="input_permission_boundary_arn"></a> [permission\_boundary\_arn](#input\_permission\_boundary\_arn) | Optional - ARN of the policy that is used to set the permissions boundary for the role. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map/dictionary of Tags to be assigned to created resources | `map(string)` | `{}` | no |
| <a name="input_use_existing_iam_role"></a> [use\_existing\_iam\_role](#input\_use\_existing\_iam\_role) | Set this to true to use an existing IAM role | `bool` | `false` | no |
| <a name="input_use_existing_iam_role_policy"></a> [use\_existing\_iam\_role\_policy](#input\_use\_existing\_iam\_role\_policy) | Set this to `true` to use an existing policy on the IAM role, rather than attaching a new one | `bool` | `false` | no |
| <a name="input_wait_time"></a> [wait\_time](#input\_wait\_time) | Amount of time to wait before the next resource is provisioned | `string` | `"10s"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_external_id"></a> [external\_id](#output\_external\_id) | The External ID configured into the IAM role |
| <a name="output_iam_role_arn"></a> [iam\_role\_arn](#output\_iam\_role\_arn) | The IAM Role ARN |
| <a name="output_iam_role_name"></a> [iam\_role\_name](#output\_iam\_role\_name) | The IAM Role name |
| <a name="output_lacework_integration_guid"></a> [lacework\_integration\_guid](#output\_lacework\_integration\_guid) | The GUID for the created Lacework integration |
<!-- END_TF_DOCS -->

## Lacework Audit Policy
Release for 0.19.0(Feb 2025):
Terraform changes to add a second policy and its attachment under the same role.(This changes is to bypass the 6144 chars limit for one policy)
Add permissions for kinesisvideo, amp, appstream, personalize, codeartifact, fis; Add missing permission for services ses, backup
Add permissions for future services to come: memoryDB, resource groups, qbusiness, qapps, qconnect, servicecatalogappregistry, oam, clouddirectory, optimizationhub, budgets,billingconsole

The audit policy is comprised of the following permissions:

| sid                        | actions                                                 | resources |
|----------------------------|---------------------------------------------------------|-----------|
| GetEbsEncryptionByDefault  | ec2:GetEbsEncryptionByDefault                           | *         |
| GetBucketPublicAccessBlock | s3:GetBucketPublicAccessBlock                           | *         |
| GetObjectLockConfiguration | s3:GetObjectLockConfiguration                           |           |
| EFS                        | elasticfilesystem:DescribeFileSystemPolicy              | *         |
|                            | elasticfilesystem:DescribeLifecycleConfiguration        |           |
|                            | elasticfilesystem:DescribeAccessPoints                  |           |
|                            | elasticfilesystem:DescribeAccountPreferences            |           |
|                            | elasticfilesystem:DescribeBackupPolicy                  |           |
|                            | elasticfilesystem:DescribeReplicationConfigurations     |           |
|                            | elasticfilesystem:ListTagsForResource                   |           |
| EMR                        | elasticmapreduce:ListBootstrapActions                   | *         |
|                            | elasticmapreduce:ListInstanceFleets                     |           |
|                            | elasticmapreduce:ListInstanceGroups                     |           |
| SAGEMAKER                  | sagemaker:GetModelPackageGroupPolicy                    | *         |
|                            | sagemaker:GetLineageGroupPolicy                         |           |
|                            | sagemaker:GetDeviceFleetReport                          |           |
| IDENTITYSTORE              | identitystore:DescribeGroup                             | *         |
|                            | identitystore:DescribeGroupMembership                   |           |
|                            | identitystore:DescribeUser                              |           |
|                            | identitystore:ListGroupMemberships                      |           |
|                            | identitystore:ListGroupMembershipsForMember             |           |
|                            | identitystore:ListGroups                                |           |
|                            | identitystore:ListUsers                                 |           |
| SSO                        | sso:DescribeAccountAssignmentDeletionStatus             | *         |
|                            | sso:DescribeInstanceAccessControlAttributeConfiguration |           |
|                            | sso:GetInlinePolicyForPermissionSet                     |           |
| GLACIER                    | glacier:ListTagsForVault                                | *         |
|                            | glacier:GetJobOutput                                    |           |
|                            | glacier:ListJobs                                        |           |
|                            | glacier:ListMultipartUploads                            |           |
|                            | glacier:ListParts                                       |           |
|                            | glacier:ListProvisionedCapacity                         |           |
|                            | glacier:GetVaultNotifications                           |           |
| APIGATEWAY                 | apigateway:GET                                          | arn:aws:apigateway:*::/apikeys, arn:aws:apigateway:*::/apikeys/*         |
| WAFREGIONAL                | waf-regional:ListRules                                  | *         |
|                            | waf-regional:GetRule                                    |           |
|                            | waf-regional:ListRuleGroups                             |           |
|                            | waf-regional:GetRuleGroup                               |           |
|                            | waf-regional:ListActivatedRulesInRuleGroup              |           |
|                            | waf-regional:ListIpSets                                 |           |
|                            | waf-regional:ListRegexPatternSets                       |           |
| GLUE                       | glue:ListWorkflows                                      | *         |
|                            | glue:BatchGetWorkflows                                  |           |
|                            | glue:GetTags                                            |           |
|                            | glue:GetTables                                          |           |
| CODEBUILD                  | codebuild:ListBuilds                                    | *         |
|                            | codebuild:BatchGetBuilds                                |           |
|                            | codebuild:BatchGetBuildBatches                          |           |
|                            | codebuild:ListBuildBatches                              |           |
|                            | codebuild:DescribeCodeCoverages                         |           |
|                            | codebuild:ListCuratedEnvironmentImages                  |           |
|                            | codebuild:BatchGetReports                               |           |
|                            | codebuild:ListReports                                   |           |
|                            | codebuild:BatchGetReportGroups                          |           |
|                            | codebuild:ListReportGroups                              |           |
|                            | codebuild:ListSharedProjects                            |           |
|                            | codebuild:ListSharedReportGroups                        |           |
|                            | codebuild:DescribeTestCases                             |           |
| SNS                        | sns:GetDataProtectionPolicy                             | *         |
|                            | sns:ListPlatformApplications                            |           |
|                            | sns:GetSubscriptionAttributes                           |           |
| SES                        | ses:ListContactLists                                    | *         |
|                            | ses:GetContactList                                      |           |
|                            | ses:ListContacts                                        |           |
|                            | ses:GetContact                                          |           |
|                            | ses:ListCustomVerificationEmailTemplates                |           |
|                            | ses:GetCustomVerificationEmailTemplate                  |           |
|                            | ses:GetDedicatedIpPool                                  |           |
|                            | ses:GetBlacklistReports                                 |           |
|                            | ses:GetDedicatedIp                                      |           |
|                            | ses:ListDeliverabilityTestReports                       |           |
|                            | ses:GetDeliverabilityTestReport                         |           |
|                            | ses:ListEmailIdentities                                 |           |
|                            | ses:GetEmailIdentity                                    |           |
|                            | ses:GetEmailIdentityPolicies                            |           |
|                            | ses:ListEmailTemplates                                  |           |
|                            | ses:GetEmailTemplate                                    |           |
|                            | ses:ListImportJobs                                      |           |
|                            | ses:GetImportJob                                        |           |
|                            | ses:ListRecommendations                                 |           |
|                            | ses:ListSuppressedDestinations                          |           |
|                            | ses:GetSuppressedDestination                            |           |
|                            | ses:ListTagsForResource                                 |           |
| BACKUP                     | backup:ListBackupJobs                                   | *         |
|                            | backup:DescribeBackupJob                                |           |
|                            | backup:ListBackupPlanTemplates                          |           |
|                            | backup:GetBackupPlanFromTemplate                        |           |
|                            | backup:ListBackupPlans                                  |           |
|                            | backup:GetBackupPlan                                    |           |
|                            | backup:ListBackupPlanVersions                           |           |
|                            | backup:ListBackupSelections                             |           |
|                            | backup:GetBackupSelection                               |           |
|                            | backup:DescribeBackupVault                              |           |
|                            | backup:ListRecoveryPointsByBackupVault                  |           |
|                            | backup:DescribeRecoveryPoint                            |           |
|                            | backup:GetRecoveryPointRestoreMetadata                  |           |
|                            | backup:ListCopyJobs                                     |           |
|                            | backup:ListFrameworks                                   |           |
|                            | backup:DescribeFramework                                |           |
|                            | backup:ListLegalHolds                                   |           |
|                            | backup:GetLegalHold                                     |           |
|                            | backup:ListRecoveryPointsByLegalHold                    |           |
|                            | backup:ListProtectedResources                           |           |
|                            | backup:DescribeProtectedResource                        |           |
|                            | backup:ListRecoveryPointsByResource                     |           |
|                            | backup:ListReportPlans                                  |           |
|                            | backup:ListRestoreJobs                                  |           |
|                            | backup:ListTags                                         |           |
| COGNITO-IDP                | cognito-idp:GetSigningCertificate                       |           |
|                            | cognito-idp:GetCSVHeader                                |           |
|                            | cognito-idp:GetUserPoolMfaConfig                        |           |
|                            | cognito-idp:GetUICustomization                          |           |
| COMPUTEOPTIMIZER           | compute-optimizer:DescribeRecommendationExportJobs      | *         |
|                            | compute-optimizer:GetAutoScalingGroupRecommendations    |           |
|                            | compute-optimizer:GetEffectiveRecommendationPreferences |           |
|                            | compute-optimizer:GetEBSVolumeRecommendations           |           |
|                            | compute-optimizer:GetEC2InstanceRecommendations         |           |
|                            | compute-optimizer:GetEnrollmentStatus                   |           |
|                            | compute-optimizer:GetLambdaFunctionRecommendations      |           |
|                            | compute-optimizer:GetRecommendationPreferences          |           |
|                            | compute-optimizer:GetRecommendationSummaries            |           |
|                            | compute-optimizer:GetEcsServiceRecommendations          |           |
|                            | compute-optimizer:GetLicenseRecommendations             |           |
| KINESISANALYTICS           | kinesisanalytics:ListApplicationSnapshots               |           |
|                            | kinesisanalytics:ListApplicationVersions                |           |
|                            | kinesisanalytics:DescribeApplicationVersion             |           |
|                            | kinesisanalytics:DescribeApplication                    |           |
| KINESISVIDEO               | kinesisvideo:GetSignalingChannelEndpoint                | *         |
|                            | kinesisvideo:GetDataEndpoint                            |           |
|                            | kinesisvideo:DescribeImageGenerationConfiguration       |           |
| AMP                        | aps:ListScrapers                                        | *         |
|                            | aps:DescribeScraper                                     |           |
|                            | aps:ListWorkspaces                                      |           |
|                            | aps:DescribeAlertManagerDefinition                      |           |
|                            | aps:DescribeLoggingConfiguration                        |           |
|                            | aps:DescribeWorkspace                                   |           |
|                            | aps:ListRuleGroupsNamespaces                            |           |
|                            | aps:DescribeRuleGroupsNamespace                         |           |
|                            | aps:ListTagsForResource                                 |           |
| APPSTREAM                  | appstream:Describe*                                     |           |
|                            | appstream:List*                                         |           |
| PERSONALIZE                | personalize:Describe*                                   |           |
|                            | personalize:List*                                       |           |
|                            | personalize:GetSolutionMetrics                          |           |
| CODEARTIFACT               | codeartifact:ListDomains                                | *         |
|                            | codeartifact:DescribeDomain                             |           |
|                            | codeartifact:DescribeRepository                         |           |
|                            | codeartifact:ListPackages                               |           |
|                            | codeartifact:GetRepositoryEndpoint                      |           |
|                            | codeartifact:DescribePackage                            |           |
|                            | codeartifact:ListPackageVersions                        |           |
|                            | codeartifact:DescribePackageVersion                     |           |
|                            | codeartifact:GetPackageVersionReadme                    |           |
|                            | codeartifact:ListPackageVersionDependencies             |           |
|                            | codeartifact:ListPackageVersionAssets                   |           |
|                            | codeartifact:GetPackageVersionAsset                     |           |
|                            | codeartifact:ListTagsForResource                        |           |
| FIS                        | fis:ListActions                                         | *         |
|                            | fis:GetAction                                           |           |
|                            | fis:ListExperimentTemplates                             |           |
|                            | fis:GetExperimentTemplate                               |           |
|                            | fis:ListTargetAccountConfigurations                     |           |
|                            | fis:ListExperiments                                     |           |
|                            | fis:GetExperiment                                       |           |
|                            | fis:ListExperimentResolvedTargets                       |           |
| MEMORYDB                   | memorydb:DescribeMultiRegionClusters                    | *         |
|                            | memorydb:DescribeSnapshots                              |           |
|                            | memorydb:DescribeSubnetGroups                           |           |
|                            | memorydb:DescribeParameterGroups                        |           |
|                            | memorydb:DescribeParameters                             |           |
|                            | memorydb:DescribeUsers                                  |           |
|                            | memorydb:DescribeACLs                                   |           |
|                            | memorydb:DescribeServiceUpdates                         |           |
|                            | memorydb:DescribeEngineVersions                         |           |
|                            | memorydb:DescribeReservedNodes                          |           |
|                            | memorydb:DescribeReservedNodesOfferings                 |           |
|                            | memorydb:ListTags                                       |           |
|                            | memorydb:ListAllowedNodeTypeUpdates                     |           |
|                            | memorydb:ListAllowedMultiRegionClusterUpdates           |           |
| QBUSINESS                  | qbusiness:GetApplication                                | *         |
|                            | qbusiness:GetChatControlsConfiguration                  |           |
|                            | qbusiness:GetPolicy                                     |           |
|                            | qbusiness:ListAttachments                               |           |
|                            | qbusiness:ListConversations                             |           |
|                            | qbusiness:ListMessages                                  |           |
|                            | qbusiness:ListDataAccessors                             |           |
|                            | qbusiness:GetDataAccessor                               |           |
|                            | qbusiness:GetIndex                                      |           |
|                            | qbusiness:GetDataSource                                 |           |
|                            | qbusiness:GetPlugin                                     |           |
|                            | qbusiness:ListPluginActions                             |           |
|                            | qbusiness:GetRetriever                                  |           |
|                            | qbusiness:GetWebExperience                              |           |
|                            | qbusiness:ListPluginTypeMetadata                        |           |
|                            | qbusiness:ListPluginTypeActions                         |           |
| QAPPS                      | qapps:DescribeQAppPermissions                           | *         |
|                            | qapps:GetLibraryItem                                    |           |
|                            | qapps:GetQApp                                           |           |
|                            | qapps:GetQAppSession                                    |           |
|                            | qapps:GetQAppSessionMetadata                            |           |
|                            | qapps:ListCategories                                    |           |
|                            | qapps:ListLibraryItems                                  |           |
|                            | qapps:ListQAppSessionData                               |           |
|                            | qapps:ListQApps                                         |           |
|                            | qapps:ListTagsForResource                               |           |
| QCONNECT                   | wisdom:GetAIAgent                                       | *         |
|                            | wisdom:GetAIGuardrail                                   |           |
|                            | wisdom:GetAIPrompt                                      |           |
|                            | wisdom:GetContent                                       |           |
|                            | wisdom:GetImportJob                                     |           |
|                            | wisdom:GetKnowledgeBase                                 |           |
|                            | wisdom:GetMessageTemplate                               |           |
|                            | wisdom:GetQuickResponse                                 |           |
|                            | wisdom:ListAIAgentVersions                              |           |
|                            | wisdom:ListAIAgents                                     |           |
|                            | wisdom:ListAIGuardrailVersions                          |           |
|                            | wisdom:ListAIGuardrails                                 |           |
|                            | wisdom:ListAIPromptVersions                             |           |
|                            | wisdom:ListAIPrompts                                    |           |
|                            | wisdom:ListAssistantAssociations                        |           |
|                            | wisdom:ListAssistants                                   |           |
|                            | wisdom:ListContentAssociations                          |           |
|                            | wisdom:ListContents                                     |           |
|                            | wisdom:ListImportJobs                                   |           |
|                            | wisdom:ListKnowledgeBases                               |           |
|                            | wisdom:ListMessageTemplateVersions                      |           |
|                            | wisdom:ListMessageTemplates                             |           |
|                            | wisdom:ListQuickResponses                               |           |
|                            | wisdom:ListTagsForResource                              |           |
| RESOURCEGROUPS             | resource-groups:ListGroups                              | *         |
|                            | resource-groups:GetGroupQuery                           |           |
|                            | resource-groups:GetGroupConfiguration                   |           |
|                            | resource-groups:GetTags                                 |           |
| SERVICECATALOGAPPREGISTRY  | servicecatalog:GetApplication                           | *         |
|                            | servicecatalog:ListApplications                         |           |
|                            | servicecatalog:GetAssociatedResource                    |           |
|                            | servicecatalog:ListAssociatedResources                  |           |
|                            | servicecatalog:ListAssociatedAttributeGroups            |           |
|                            | servicecatalog:GetAttributeGroup                        |           |
|                            | servicecatalog:ListAttributeGroups                      |           |
|                            | servicecatalog:ListTagsForResource                      |           |
|                            | servicecatalog:ListAttributeGroupsForApplication        |           |
|                            | servicecatalog:GetConfiguration                         |           |
| OAM                        | oam:GetLink                                             | *         |
|                            | oam:GetSink                                             |           |
|                            | oam:GetSinkPolicy                                       |           |
|                            | oam:ListAttachedLinks                                   |           |
|                            | oam:ListLinks                                           |           |
|                            | oam:ListSinks                                           |           |
| CLOUDDIRECTORY             | clouddirectory:GetAppliedSchemaVersion                  | *         |
|                            | clouddirectory:GetDirectory                             |           |
|                            | clouddirectory:GetFacet                                 |           |
|                            | clouddirectory:GetLinkAttributes                        |           |
|                            | clouddirectory:GetObjectAttributes                      |           |
|                            | clouddirectory:GetObjectInformation                     |           |
|                            | clouddirectory:GetSchemaAsJson                          |           |
|                            | clouddirectory:GetTypedLinkFacetInformation             |           |
|                            | clouddirectory:ListAppliedSchemaArns                    |           |
|                            | clouddirectory:ListAttachedIndices                      |           |
|                            | clouddirectory:ListDevelopmentSchemaArns                |           |
|                            | clouddirectory:ListFacetAttributes                      |           |
|                            | clouddirectory:ListFacetNames                           |           |
|                            | clouddirectory:ListIncomingTypedLinks                   |           |
|                            | clouddirectory:ListIndex                                |           |
|                            | clouddirectory:ListManagedSchemaArns                    |           |
|                            | clouddirectory:ListObjectAttributes                     |           |
|                            | clouddirectory:ListObjectChildren                       |           |
|                            | clouddirectory:ListObjectParentPaths                    |           |
|                            | clouddirectory:ListObjectParents                        |           |
|                            | clouddirectory:ListObjectPolicies                       |           |
|                            | clouddirectory:ListOutgoingTypedLinks                   |           |
|                            | clouddirectory:ListPolicyAttachments                    |           |
|                            | clouddirectory:ListPublishedSchemaArns                  |           |
|                            | clouddirectory:ListTagsForResource                      |           |
|                            | clouddirectory:ListTypedLinkFacetAttributes             |           |
|                            | clouddirectory:ListTypedLinkFacetNames                  |           |
| COSTOPTIMIZATIONHUB        | cost-optimization-hub:GetPreferences                    | *         |
|                            | cost-optimization-hub:GetRecommendation                 |           |
|                            | cost-optimization-hub:ListEnrollmentStatuses            |           |
|                            | cost-optimization-hub:ListRecommendationSummaries       |           |
|                            | cost-optimization-hub:ListRecommendations               |           |
| BUDGETS                    | budgets:DescribeBudgetAction                            | *         |
|                            | budgets:DescribeBudgetActionHistories                   |           |
|                            | budgets:DescribeBudgetActionsForAccount                 |           |
|                            | budgets:DescribeBudgetActionsForBudget                  |           |
|                            | budgets:ListTagsForResource                             |           |
|                            | budgets:ViewBudget                                      |           |
|                            | budgets:DescribeBudgets                                 |           |
|                            | budgets:DescribeBudgetPerformanceHistory                |           |
|                            | budgets:DescribeNotificationsForBudget                  |           |
|                            | budgets:DescribeSubscribersForNotification              |           |
| BILLINGCONSOLE             | aws-portal:GetConsoleActionSetEnforced                  | *         |
|                            | aws-portal:ViewAccount                                  |           |
|                            | aws-portal:ViewBilling                                  |           |
|                            | aws-portal:ViewPaymentMethods                           |           |
|                            | aws-portal:ViewUsage                                    |           |
| ACM-PCA                    | acm-pca:GetCertificateAuthorityCertificate              | *         |
|                            | acm-pca:GetCertificateAuthorityCertificate              | *         |
|                            | acm-pca:GetCertificateAuthorityCsr                      |           |
| APPCONFIG                  | appconfig:GetConfigurationProfile                       | *         |
|                            | appconfig:GetDeploymentStrategy                         |           |
|                            | appconfig:GetExtension                                  |           |
|                            | appconfig:GetExtensionAssociation                       |           |
|                            | appconfig:GetHostedConfigurationVersion                 |           |
|                            | appconfig:ListApplications                              |           |
|                            | appconfig:ListConfigurationProfiles                     |           |
|                            | appconfig:ListDeployments                               |           |
|                            | appconfig:ListDeploymentStrategies                      |           |
|                            | appconfig:ListEnvironments                              |           |
|                            | appconfig:ListExtensionAssociations                     |           |
|                            | appconfig:ListExtensions                                |           |
|                            | appconfig:ListHostedConfigurationVersions               |           |
|                            | appconfig:ListTagsForResource                           |           |
|                            | appconfig:GetDeployment                                 |           |
| APPFLOW                    | appflow:DescribeConnectorEntity                         | *         |
|                            | appflow:DescribeConnectorProfiles                       |           |
|                            | appflow:DescribeConnectors                              |           |
|                            | appflow:DescribeFlow                                    |           |
|                            | appflow:DescribeFlowExecutionRecords                    |           |
|                            | appflow:ListConnectorEntities                           |           |
|                            | appflow:ListConnectors                                  |           |
|                            | appflow:DescribeConnector                               |           |
| DYNAMODB                   | dynamodb:DescribeContributorInsights                    | *         |
|                            | dynamodb:GetResourcePolicy                              |           |
|                            | dynamodb:DescribeBackup                                 |           |
| EBS                        | ebs:GetSnapshotBlock                                    | *         |
|                            | ebs:ListSnapshotBlocks                                  |           |
| FREETIER                   | freetier:GetFreeTierUsage                               | *         |
| LAKEFORMATION              | lakeformation:DescribeLakeFormationIdentityCenterConfiguration | *  |
|                            | lakeformation:GetDataLakePrincipal                      |           |
|                            | lakeformation:GetDataLakeSettings                       |           |
|                            | lakeformation:GetEffectivePermissionsForPath            |           |
|                            | lakeformation:GetTableObjects                           |           |
|                            | lakeformation:ListDataCellsFilter                       |           |
|                            | lakeformation:ListPermissions                           |           |
|                            | lakeformation:ListResources                             |           |
|                            | lakeformation:ListTableStorageOptimizers                |           |
|                            | lakeformation:ListTransactions                          |           |
| LAMBDA                     | lambda:GetFunction                                      | *         |
|                            | lambda:GetFunctionCodeSigningConfig                     |           |
| SCHEDULER                  | scheduler:GetSchedule                                   | *         |
|                            | scheduler:GetScheduleGroup                              |           |
|                            | scheduler:ListScheduleGroups                            |           |
|                            | scheduler:ListSchedules                                 |           |
|                            | scheduler:ListTagsForResource                           |           |
| SCHEMAS                    | schemas:GetCodeBindingSource                            | *         |
| DATASYNC                   | datasync:DescribeTaskExecution                          | *         |
|                            | datasync:DescribeLocationEfs                            |           |
|                            | datasync:ListAgents                                     |           |
|                            | datasync:ListLocations                                  |           |
|                            | datasync:ListTaskExecutions                             |           |
|                            | datasync:ListStorageSystems                             |           |
|                            | datasync:DescribeLocationSmb                            |           |
|                            | datasync:DescribeAgent                                  |           |
|                            | datasync:DescribeLocationFsxWindows                     |           |
|                            | datasync:DescribeTask                                   |           |
|                            | datasync:DescribeLocationS3                             |           |
|                            | datasync:DescribeDiscoveryJob                           |           |
|                            | datasync:DescribeLocationObjectStorage                  |           |
|                            | datasync:DescribeStorageSystem                          |           |
|                            | datasync:DescribeLocationAzureBlob                      |           |
|                            | datasync:ListTagsForResource                            |           |
|                            | datasync:ListTasks                                      |           |
|                            | datasync:DescribeLocationHdfs                           |           |
|                            | datasync:DescribeLocationFsxLustre                      |           |
|                            | datasync:ListDiscoveryJobs                              |           |
|                            | datasync:DescribeLocationNfs                            |           |
| IOT                        | iot:GetCommand                                          | *         |
|                            | iot:GetCommandExecution                                 |           |
|                            | iot:GetEffectivePolicies                                |           |
|                            | iot:GetIndexingConfiguration                            |           |
|                            | iot:GetJobDocument                                      |           |
|                            | iot:GetV2LoggingOptions                                 |           |
|                            | iot:GetOtaUpdate                                        |           |
|                            | iot:GetPackage                                          |           |
|                            | iot:GetPackageConfiguration                             |           |
|                            | iot:GetPackageVersion                                   |           |
|                            | iot:GetRegistrationCode                                 |           |
|                            | iot:GetBehaviorModelTrainingSummaries                   |           |
|                            | iot:GetThingConnectivityData                            |           |
|                            | iot:GetTopicRule                                        |           |
|                            | iot:GetTopicRuleDestination                             |           |
|                            | iotevents:DescribeAlarmModel                            |           |
| IOTEVENTS                  | iotevents:ListAlarmModels                               | *         |
|                            | iotevents:ListTagsForResource                           |           |
|                            | iotevents:ListAlarmModelVersions                        |           |
|                            | iotevents:DescribeDetectorModel                         |           |
|                            | iotevents:ListDetectorModels                            |           |
|                            | iotevents:ListDetectorModelVersions                     |           |
|                            | iotevents:DescribeInput                                 |           |
|                            | iotevents:DescribeLoggingOptions                        |           |
| MEDIAPACKAGE               | mediapackage:ListChannels                               | *         |
|                            | mediapackage:ListHarvestJobs                            |           |
|                            | mediapackage:ListTagsForResource                        |           |
| MEDIAPACKAGEV2             | mediapackagev2:GetChannel                               | *         |
|                            | mediapackagev2:GetChannelPolicy                         |           |
|                            | mediapackagev2:ListChannels                             |           |
|                            | mediapackagev2:ListTagsForResource                      |           |
|                            | mediapackagev2:GetChannelGroup                          |           |
|                            | mediapackagev2:ListChannelGroups                        |           |
|                            | mediapackagev2:ListHarvestJobs                          |           |
|                            | mediapackagev2:GetOriginEndpoint                        |           |
|                            | mediapackagev2:GetOriginEndpointPolicy                  |           |
|                            | mediapackagev2:ListOriginEndpoints                      |           |
| MEDIAPACKAGE-VOD           | mediapackage-vod:DescribeAsset                          | *         |
|                            | mediapackage-vod:ListAssets                             |           |
|                            | mediapackage-vod:ListPackagingConfigurations            |           |
|                            | mediapackage-vod:ListPackagingGroups                    |           |
| SUPPORT                    | support:DescribeCases                                   | *         |
|                            | support:DescribeCommunications                          |           |
|                            | support:DescribeServices                                |           |
|                            | support:DescribeSeverityLevels                          |           |
| IMAGEBUILDER               | imagebuilder:GetComponentPolicy                         | *         |
|                            | imagebuilder:ListComponents                             |           |
|                            | imagebuilder:ListTagsForResource                        |           |
|                            | imagebuilder:GetComponent                               |           |
|                            | imagebuilder:ListComponentBuildVersions                 |           |
|                            | imagebuilder:GetContainerRecipe                         |           |
|                            | imagebuilder:GetContainerRecipePolicy                   |           |
|                            | imagebuilder:ListContainerRecipes                       |           |
|                            | imagebuilder:GetDistributionConfiguration               |           |
|                            | imagebuilder:ListDistributionConfigurations             |           |
|                            | imagebuilder:GetImagePolicy                             |           |
|                            | imagebuilder:ListImages                                 |           |
|                            | imagebuilder:GetImage                                   |           |
|                            | imagebuilder:ListImageBuildVersions                     |           |
|                            | imagebuilder:ListImagePackages                          |           |
|                            | imagebuilder:GetImagePipeline                           |           |
|                            | imagebuilder:ListImagePipelines                         |           |
|                            | imagebuilder:GetImageRecipe                             |           |
|                            | imagebuilder:GetImageRecipePolicy                       |           |
|                            | imagebuilder:ListImageRecipes                           |           |
|                            | imagebuilder:ListImageScanFindings                      |           |
|                            | imagebuilder:ListImageScanFindingAggregations           |           |
|                            | imagebuilder:GetInfrastructureConfiguration             |           |
|                            | imagebuilder:ListInfrastructureConfigurations           |           |
|                            | imagebuilder:ListLifecycleExecutions                    |           |
|                            | imagebuilder:ListLifecycleExecutionResources            |           |
|                            | imagebuilder:GetLifecyclePolicy                         |           |
|                            | imagebuilder:ListLifecyclePolicies                      |           |
|                            | imagebuilder:ListWorkflows                              |           |
|                            | imagebuilder:GetWorkflow                                |           |
|                            | imagebuilder:ListWorkflowBuildVersions                  |           |
|                            | imagebuilder:ListWorkflowExecutions                     |           |
|                            | imagebuilder:GetWorkflowStepExecution                   |           |
|                            | imagebuilder:ListWorkflowStepExecutions                 |           |
| DETECTIVE                  | detective:BatchGetMembershipDatasources                 | *         |
|                            | detective:ListDatasourcePackages                        |           |
|                            | detective:ListTagsForResource                           |           |
|                            | detective:GetInvestigation                              |           |
|                            | detective:ListIndicators                                |           |
|                            | detective:ListInvestigations                            |           |
|                            | detective:ListInvitations                               |           |
|                            | detective:BatchGetGraphMemberDatasources                |           |
|                            | detective:ListOrganizationAdminAccounts                 |           |
| BATCH                      | batch:DescribeJobs                                      | *         |
|                            | batch:ListJobs                                          |           |
|                            | batch:ListTagsForResource                               |           |
|                            | batch:DescribeJobQueues                                 |           |
|                            | batch:DescribeSchedulingPolicies                        |           |
|                            | batch:ListSchedulingPolicies                            |           |
| NETWORKMANAGER             | networkmanager:GetConnectAttachment                     | *         |
|                            | networkmanager:GetSiteToSiteVpnAttachment               |           |
|                            | networkmanager:GetTransitGatewayRouteTableAttachment    |           |
|                            | networkmanager:GetVpcAttachment                         |           |
|                            | networkmanager:ListAttachments                          |           |
|                            | networkmanager:GetConnectPeer                           |           |
|                            | networkmanager:ListConnectPeers                         |           |
|                            | networkmanager:GetCoreNetwork                           |           |
|                            | networkmanager:GetCoreNetworkChangeEvents               |           |
|                            | networkmanager:GetCoreNetworkChangeSet                  |           |
|                            | networkmanager:GetCoreNetworkPolicy                     |           |
|                            | networkmanager:GetNetworkRoutes                         |           |
|                            | networkmanager:ListCoreNetworkPolicyVersions            |           |
|                            | networkmanager:ListCoreNetworks                         |           |
|                            | networkmanager:GetConnectPeerAssociations               |           |
|                            | networkmanager:GetConnections                           |           |
|                            | networkmanager:GetCustomerGatewayAssociations           |           |
|                            | networkmanager:GetDevices                               |           |
|                            | networkmanager:GetLinkAssociations                      |           |
|                            | networkmanager:GetLinks                                 |           |
|                            | networkmanager:GetNetworkResourceCounts                 |           |
|                            | networkmanager:GetNetworkResourceRelationships          |           |
|                            | networkmanager:GetNetworkResources                      |           |
|                            | networkmanager:GetNetworkTelemetry                      |           |
|                            | networkmanager:GetResourcePolicy                        |           |
|                            | networkmanager:GetSites                                 |           |
|                            | networkmanager:GetTransitGatewayConnectPeerAssociations |           |
|                            | networkmanager:GetTransitGatewayRegistrations           |           |
|                            | networkmanager:GetTransitGatewayPeering                 |           |
|                            | networkmanager:ListPeerings                             |           |
| CODEPIPELINE               | codepipeline:ListActionExecutions                       | *         |
|                            | codepipeline:GetActionType                              |           |
|                            | codepipeline:ListActionTypes                            |           |
|                            | codepipeline:ListTagsForResource                        |           |
|                            | codepipeline:ListPipelineExecutions                     |           |
|                            | codepipeline:ListRuleExecutions                         |           |
|                            | codepipeline:ListRuleTypes                              |           |
|                            | codepipeline:ListWebhooks                               |           |
| GREENGRASS                 | greengrass:GetBulkDeploymentStatus                      | *         |
|                            | greengrass:GetGroupCertificateAuthority                 |           |
|                            | greengrass:GetConnectorDefinitionVersion                |           |
|                            | greengrass:GetCoreDefinitionVersion                     |           |
|                            | greengrass:GetDeploymentStatus                          |           |
|                            | greengrass:GetDeviceDefinitionVersion                   |           |
|                            | greengrass:GetFunctionDefinitionVersion                 |           |
|                            | greengrass:GetAssociatedRole                            |           |
|                            | greengrass:GetGroupCertificateConfiguration             |           |
|                            | greengrass:GetGroupVersion                              |           |
|                            | greengrass:GetLoggerDefinitionVersion                   |           |
|                            | greengrass:GetResourceDefinitionVersion                 |           |
|                            | greengrass:GetServiceRoleForAccount                     |           |
|                            | greengrass:GetSubscriptionDefinitionVersion             |           |
|                            | greengrass:DescribeComponent                            |           |
| GREENGRASSV2               | greengrass:GetComponent                                 | *         |
|                            | greengrass:GetConnectivityInfo                          |           |
|                            | greengrass:GetCoreDevice                                |           |
|                            | greengrass:GetDeployment                                |           |
|                            | greengrass:GetServiceRoleForAccount                     |           |
| INSPECTOR2                 | inspector2:BatchGetCodeSnippet                          | *         |
|                            | inspector2:ListCisScanResultsAggregatedByChecks         |           |
|                            | inspector2:ListCisScanResultsAggregatedByTargetResource |           |
|                            | inspector2:ListCisScanConfigurations                    |           |
|                            | inspector2:ListMembers                                  |           |
|                            | inspector2:BatchGetFindingDetails                       |           |
|                            | inspector2:GetCisScanReport                             |           |
|                            | inspector2:GetCisScanResultDetails                      |           |
|                            | inspector2:ListCisScans                                 |           |
|                            | inspector2:GetEncryptionKey                             |           |
| SSM                        | ssm:GetConnectionStatus                                 | *         |
|                            | ssm:ListCommandInvocations                              |           |
|                            | ssm:GetDocument                                         |           |
|                            | ssm:GetInventory                                        |           |
|                            | ssm:GetMaintenanceWindowExecutionTask                   |           |
|                            | ssm:GetMaintenanceWindowTask                            |           |
|                            | ssm:GetOpsItem                                          |           |
|                            | ssm:ListOpsItemEvents                                   |           |
|                            | ssm:ListOpsItemRelatedItems                             |           |
|                            | ssm:GetOpsMetadata                                      |           |
|                            | ssm:GetParameter                                        |           |
|                            | ssm:GetParameterHistory                                 |           |
|                            | ssm:GetPatchBaseline                                    |           |
|                            | ssm:GetPatchBaselineForPatchGroup                       |           |
|                            | ssm:GetResourcePolicies                                 |           |
| EKS                        | ssm:DescribeAddon                                       | *         |
| WAF                        | waf:GetRegexPatternSet                                  | *         |
|                            | waf:GetPermissionPolicy                                 |           |
|                            | waf:ListIPSets                                          |           |
|                            | waf:ListTagsForResource                                 |           |
|                            | waf:ListRuleGroups                                      |           |
|                            | waf:GetRuleGroup                                        |           |
|                            | waf:GetLoggingConfiguration                             |           |
|                            | waf:ListRegexPatternSets                                |           |
|                            | waf:GetWebACL                                           |           |
|                            | waf:ListActivatedRulesInRuleGroup                       |           |
|                            | waf:GetByteMatchSet                                     |           |
|                            | waf:ListByteMatchSets                                   |           |
|                            | waf:GetGeoMatchSet                                      |           |
|                            | waf:ListGeoMatchSets                                    |           |
|                            | waf:GetLoggingConfiguration                             |           |
|                            | waf:ListLoggingConfigurations                           |           |
|                            | waf:GetRateBasedRule                                    |           |
|                            | waf:GetRateBasedRuleManagedKeys                         |           |
|                            | waf:ListRateBasedRules                                  |           |
|                            | waf:GetRegexMatchSet                                    |           |
|                            | waf:ListRegexMatchSets                                  |           |
|                            | waf:ListRegexPatternSets                                |           |
|                            | waf:GetRule                                             |           |
|                            | waf:ListRules                                           |           |
|                            | waf:ListRuleGroups                                      |           |
|                            | waf:GetSizeConstraintSet                                |           |
|                            | waf:ListSizeConstraintSets                              |           |
|                            | waf:GetSqlInjectionMatchSet                             |           |
|                            | waf:ListSqlInjectionMatchSets                           |           |
|                            | waf:GetXssMatchSet                                      |           |
|                            | waf:ListXssMatchSets                                    |           |
| WAFV2                      | wafv2:ListResourcesForWebACL                            | *         |
|                            | wafv2:ListRuleGroups                                    |           |
|                            | wafv2:ListWebACL                                        |           |
|                            | wafv2:ListTagsForResource                               |           |
|                            | wafv2:GetLoggingConfiguration                           |           |
|                            | wafv2:GetIPSet                                          |           |
|                            | wafv2:ListIPSets                                        |           |
|                            | wafv2:GetWebACL                                         |           |
|                            | wafv2:ListManagedRuleSet                                |           |
|                            | wafv2:GetRuleGroup                                      |           |
|                            | wafv2:ListRegexPatternSets                              |           |
|                            | wafv2:GetManagedRuleSet                                 |           |
|                            | wafv2:GetRegexPatternSet                                |           |
|                            | wafv2:ListRegexPatternSets                              |           |
| APPRUNNER                  | apprunner:ListServicesForAutoScalingConfiguration       | *         |
| APPSYNC                    | appsync:GetApiAssociation                               | *         |
| ATHENA                     | athena:GetCalculationExecution                          | *         |
|                            | athena:GetCalculationExecutionCode                      |           |
|                            | athena:GetCalculationExecutionStatus                    |           |
|                            | athena:GetDataCatalog                                   |           |
|                            | athena:GetNamedQuery                                    |           |
|                            | athena:GetPreparedStatement                             |           |
|                            | athena:GetQueryExecution                                |           |
|                            | athena:GetQueryResults                                  |           |
|                            | athena:GetQueryRuntimeStatistics                        |           |
|                            | athena:GetSession                                       |           |
|                            | athena:GetSessionStatus                                 |           |
| CE                         | ce:GetCommitmentPurchaseAnalysis                        | *         |
|                            | ce:ListCommitmentPurchaseAnalyses                       |           |
|                            | ce:GetAnomalyMonitors                                   |           |
|                            | ce:ListTagsForResource                                  |           |
|                            | ce:GetAnomalySubscriptions                              |           |
|                            | ce:ListCostAllocationTagBackfillHistory                 |           |
|                            | ce:ListCostAllocationTags                               |           |
|                            | ce:DescribeCostCategoryDefinition                       |           |
|                            | ce:ListCostCategoryDefinitions                          |           |
| CLOUDFORMATION             | cloudformation:DescribeAccountLimits                    | *         |
|                            | cloudformation:DescribeChangeSet                        |           |
|                            | cloudformation:ListChangeSets                           |           |
|                            | cloudformation:DescribeChangeSetHooks                   |           |
|                            | cloudformation:ListExports                              |           |
|                            | cloudformation:ListImports                              |           |
|                            | cloudformation:DescribePublisher                        |           |
|                            | cloudformation:DetectStackDrift                         |           |
|                            | cloudformation:GetTemplateSummary                       |           |
|                            | cloudformation:DetectStackSetDrift                      |           |
|                            | cloudformation:DescribeType                             |           |
|                            | cloudformation:ListTypes                                |           |
|                            | cloudformation:DescribeTypeRegistration                 |           |
|                            | cloudformation:ListTypeRegistrations                    |           |
|                            | cloudformation:ListTypeVersions                         |           |
| ELASTICBEANSTALK           | elasticbeanstalk:ListAvailableSolutionStacks            | *         |
|                            | elasticbeanstalk:RetrieveEnvironmentInfo                |           |
|                            | elasticbeanstalk:ListPlatformBranches                   |           |
|                            | elasticbeanstalk:ListPlatformVersions                   |           |
| MEDIATAILOR                | mediatailor:ListAlerts                                  | *         |
|                            | mediatailor:DescribeChannel                             |           |
|                            | mediatailor:DescribeProgram                             |           |
|                            | mediatailor:GetChannelPolicy                            |           |
|                            | mediatailor:GetChannelSchedule                          |           |
|                            | mediatailor:ListChannels                                |           |
|                            | mediatailor:DescribeLiveSource                          |           |
|                            | mediatailor:ListLiveSources                             |           |
|                            | mediatailor:GetPlaybackConfiguration                    |           |
|                            | mediatailor:ListPlaybackConfigurations                  |           |
|                            | mediatailor:GetPrefetchSchedule                         |           |
|                            | mediatailor:ListPrefetchSchedules                       |           |
|                            | mediatailor:DescribeSourceLocation                      |           |
|                            | mediatailor:ListSourceLocations                         |           |
|                            | mediatailor:DescribeVodSource                           |           |
|                            | mediatailor:ListVodSources                              |           |
| NETWORKFIREWALL            | network-firewall:ListTagsForResource                    | *         |
|                            | network-firewall:DescribeRuleGroupMetadata              |           |
| RESILIENCEHUB              | resiliencehub:ListAppAssessments                        | *         |
|                            | resiliencehub:DescribeAppAssessment                     |           |
|                            | resiliencehub:ListAlarmRecommendations                  |           |
|                            | resiliencehub:ListAppAssessmentComplianceDrifts         |           |
|                            | resiliencehub:ListAppAssessmentResourceDrifts           |           |
|                            | resiliencehub:ListAppComponentCompliances               |           |
|                            | resiliencehub:ListAppComponentRecommendations           |           |
|                            | resiliencehub:ListSopRecommendations                    |           |
|                            | resiliencehub:ListTestRecommendations                   |           |
|                            | resiliencehub:ListApps                                  |           |
|                            | resiliencehub:DescribeApp                               |           |
|                            | resiliencehub:DescribeDraftAppVersionResourcesImportStatus |        |
|                            | resiliencehub:DescribeResourceGroupingRecommendationTask|           |
|                            | resiliencehub:ListAppVersions                           |           |
|                            | resiliencehub:DescribeAppVersion                        |           |
|                            | resiliencehub:DescribeAppVersionResource                |           |
|                            | resiliencehub:DescribeAppVersionResourcesResolutionStatus |         |
|                            | resiliencehub:DescribeAppVersionTemplate                |           |
|                            | resiliencehub:ListAppInputSources                       |           |
|                            | resiliencehub:ListAppVersionAppComponents               |           |
|                            | resiliencehub:ListAppVersionResourceMappings            |           |
|                            | resiliencehub:ListAppVersionResources                   |           |
|                            | resiliencehub:ListUnsupportedAppVersionResources        |           |
|                            | resiliencehub:ListRecommendationTemplates               |           |
|                            | resiliencehub:ListResiliencyPolicies                    |           |
|                            | resiliencehub:ListResourceGroupingRecommendations       |           |
|                            | resiliencehub:ListTagsForResource                       |           |
|                            | resiliencehub:ListSuggestedResiliencyPolicies           |           |
| RESOURCEEXPLORER2          | resource-explorer-2:ListIndexes                         | *         |
|                            | resource-explorer-2:ListManagedViews                    |           |
|                            | resource-explorer-2:GetManagedView                      |           |
|                            | resource-explorer-2:ListSupportedResourceTypes          |           |
|                            | resource-explorer-2:ListViews                           |           |
|                            | resource-explorer-2:GetView                             |           |
|                            | resource-explorer-2:ListResources                       |           |
|                            | resource-explorer-2:GetAccountLevelServiceConfiguration |           |
|                            | resource-explorer-2:GetDefaultView                      |           |
|                            | resource-explorer-2:GetIndex                            |           |
|                            | resource-explorer-2:ListTagsForResource                 |           |
| ROUTE53DOMAINS             | route53domains:ViewBilling                              | *         |
|                            | route53domains:CheckDomainAvailability                  |           |
|                            | route53domains:CheckDomainTransferability               |           |
|                            | route53domains:ListPrices                               |           |
| SERVICEDISCOVERY           | servicediscovery:GetInstance                            | *         |
|                            | servicediscovery:ListInstances                          |           |
|                            | servicediscovery:GetNamespace                           |           |
|                            | servicediscovery:ListNamespaces                         |           |
|                            | servicediscovery:ListTagsForResource                    |           |
|                            | servicediscovery:GetOperation                           |           |
|                            | servicediscovery:ListOperations                         |           |
|                            | servicediscovery:GetService                             |           |
|                            | servicediscovery:GetServiceAttributes                   |           |
|                            | servicediscovery:ListServices                           |           |
| STEPFUNCTIONS              | stepfunctions:GetActivityTask                           | *         |
|                            | stepfunctions:ListActivities                            |           |
|                            | stepfunctions:DescribeExecution                         |           |
|                            | stepfunctions:GetExecutionHistory                       |           |
|                            | stepfunctions:ListExecutions                            |           |
|                            | stepfunctions:DescribeMapRun                            |           |
|                            | stepfunctions:ListMapRuns                               |           |
