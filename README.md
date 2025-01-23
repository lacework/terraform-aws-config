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
| [aws_iam_role_policy_attachment.lacework_audit_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.lacework_audit_policy_attachment_b](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.security_audit_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [lacework_integration_aws_cfg.default](https://registry.terraform.io/providers/lacework/lacework/latest/docs/resources/integration_aws_cfg) | resource |
| [random_id.uniq](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [time_sleep.wait_time](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [aws_iam_policy_document.lacework_audit_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.lacework_audit_policy_2025_1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
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

The Lacework audit policy extends the SecurityAudit policy to facilitate the reading of additional configuration resources.
As of 1/22/2025, we have exceeded the limit of 6144 characters for a single policy, thus every service starting with codeartifact are in a new policy.
The audit policy is comprised of the following permissions:

| sid                        | actions                                                 | resources |
|----------------------------|---------------------------------------------------------|-----------|
| GetEbsEncryptionByDefault  | ec2:GetEbsEncryptionByDefault                           | *         |
| GetBucketPublicAccessBlock | s3:GetBucketPublicAccessBlock                           | *         |
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
| APIGATEWAY                 | apigateway:GET                                          | arn:aws:apigateway:*::/apikeys, arn:aws:apigateway:*::/apikeys/*         |
| WAFREGIONAL                | waf-regional:ListRules                                  | *         |
|                            | waf-regional:GetRule                                    |           |
|                            | waf-regional:ListRuleGroups                             |           |
|                            | waf-regional:GetRuleGroup                               |           |
|                            | waf-regional:ListActivatedRulesInRuleGroup              |           |
| GLUE                       | glue:ListWorkflows                                      | *         |
|                            | glue:BatchGetWorkflows                                  |           |
|                            | glue:GetTags                                            |           |
| CODEBUILD                  | codebuild:ListBuilds                                    | *         |
|                            | codebuild:BatchGetBuilds                                |           |
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
| FIS                        | fis:ListActions                                         | *         |
|                            | fis:GetAction                                           |           |
|                            | fis:ListExperimentTemplates                             |           |
|                            | fis:GetExperimentTemplate                               |           |
|                            | fis:ListTargetAccountConfigurations                     |           |
|                            | fis:ListExperiments                                     |           |
|                            | fis:GetExperiment                                       |           |
|                            | fis:ListExperimentResolvedTargets                       |           |