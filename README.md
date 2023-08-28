<a href="https://lacework.com"><img src="https://techally-content.s3-us-west-1.amazonaws.com/public-content/lacework_logo_full.png" width="600"></a>

# terraform-aws-config

[![GitHub release](https://img.shields.io/github/release/lacework/terraform-aws-config.svg)](https://github.com/lacework/terraform-aws-config/releases/)
[![Codefresh build status]( https://g.codefresh.io/api/badges/pipeline/lacework/terraform-modules%2Ftest-compatibility?type=cf-1&key=eyJhbGciOiJIUzI1NiJ9.NWVmNTAxOGU4Y2FjOGQzYTkxYjg3ZDEx.RJ3DEzWmBXrJX7m38iExJ_ntGv4_Ip8VTa-an8gBwBo)]( https://g.codefresh.io/pipelines/edit/new/builds?id=607e25e6728f5a6fba30431b&pipeline=test-compatibility&projects=terraform-modules&projectId=607db54b728f5a5f8930405d)

Terraform module for configuring an integration with Lacework and AWS for cloud resource configuration assessment.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.35.0, < 5.0.0 |
| <a name="requirement_lacework"></a> [lacework](#requirement\_lacework) | ~> 1.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 2.1 |
| <a name="requirement_time"></a> [time](#requirement\_time) | ~> 0.6 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.35.0, < 5.0.0 |
| <a name="provider_lacework"></a> [lacework](#provider\_lacework) | ~> 1.0 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 2.1 |
| <a name="provider_time"></a> [time](#provider\_time) | ~> 0.6 |

## Inputs

| Name                         | Description                                                                                                                                                         | Type          | Default          | Required |
| ---------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------- | ---------------- | :------: |
| external_id_length           | The length of the external ID to generate. Max length is 1224. Ignored when use_existing_iam_role is set to `true`                                                  | `number`      | `16`             |    no    |
| iam_role_arn                 | The IAM role ARN is required when setting use_existing_iam_role to `true`                                                                                           | `string`      | `""`             |    no    |
| iam_role_external_id         | The external ID configured inside the IAM role is required when setting use_existing_iam_role to `true`                                                             | `string`      | `""`             |    no    |
| iam_role_name                | The IAM role name. Required to match with iam_role_arn if use_existing_iam_role is set to `true`                                                                    | `string`      | `""`             |    no    |
| lacework_aws_account_id      | The Lacework AWS account that the IAM role will grant access                                                                                                        | `string`      | `"434813966438"` |    no    |
| lacework_integration_name    | The name of the integration in Lacework                                                                                                                             | `string`      | `"TF config"`    |    no    |
| lacework_audit_policy_name   | The name of the custom audit policy (which extends SecurityAudit) to allow Lacework to read configs.  Defaults to `lwaudit-policy-${random_id.uniq.hex}` when empty | `string`      | `""`             |    no    |
| tags                         | A map/dictionary of Tags to be assigned to created resources                                                                                                        | `map(string)` | `{}`             |    no    |
| use_existing_iam_role        | Set this to true to use an existing IAM role                                                                                                                        | `bool`        | `false`          |    no    |
| use_existing_iam_role_policy | Set this to `true` to use an existing policy on the IAM role                                                                                                        | `bool`        | `false`          |    no    |
| wait_time                    | Amount of time to wait before the next resource is provisioned                                                                                                      | `string`      | `"10s"`          |    no    |

## Outputs

| Name          | Description                                  |
| ------------- | -------------------------------------------- |
| external_id   | The External ID configured into the IAM role |
| iam_role_arn  | The IAM Role ARN                             |
| iam_role_name | The IAM Role name                            |

## Lacework Audit Policy

The Lacework audit policy extends the SecurityAudit policy to facilitate the reading of additional configuration resources.
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
| APIGATEWAY                 | apigateway:GetApiKeys                                   | *         |
|                            | apigateway:GetAuthorizers                               |           |
|                            | apigateway:GetBasePathMappings                          |           |
|                            | apigateway:GetClientCertificates                        |           |
|                            | apigateway:GetDeployments                               |           |
|                            | apigateway:GetDocumentationParts                        |           |
|                            | apigateway:GetDocumentationVersions                     |           |
|                            | apigateway:GetDomainNames                               |           |
|                            | apigateway:GetGatewayResponses                          |           |
|                            | apigateway:GetModels                                    |           |
|                            | apigateway:GetModelTemplate                             |           |
|                            | apigateway:GetRequestValidators                         |           |
|                            | apigateway:GetResources                                 |           |
|                            | apigateway:GetRestApis                                  |           |
|                            | apigateway:GetSdk                                       |           |
|                            | apigateway:GetSdkTypes                                  |           |
|                            | apigateway:GetStages                                    |           |
|                            | apigateway:GetTags                                      |           |
|                            | apigateway:GetUsagePlanKeys                             |           |
|                            | apigateway:GetUsagePlans                                |           |
|                            | apigateway:GetVpcLinks                                  |           |
| APIGATEWAYV2               | apigatewayv2:GetApis                                    | *         |
|                            | apigatewayv2:GetApiMappings                             |           |
|                            | apigatewayv2:GetAuthorizers                             |           |
|                            | apigatewayv2:GetDeployments                             |           |
|                            | apigatewayv2:GetDomainNames                             |           |
|                            | apigatewayv2:GetIntegrations                            |           |
|                            | apigatewayv2:GetIntegrationResponses                    |           |
|                            | apigatewayv2:GetModelTemplate                           |           |
|                            | apigatewayv2:GetModels                                  |           |
|                            | apigatewayv2:GetRoute                                   |           |
|                            | apigatewayv2:GetRouteResponses                          |           |
|                            | apigatewayv2:GetStages                                  |           |
|                            | apigatewayv2:GetVpcLinks                                |           |
| STEPFUNCTIONS              | stepfunctions:ListActivities                            | *         |
|                            | stepfunctions:ListExecutions                            |           |
|                            | stepfunctions:ListStateMachines                         |           |
|                            | stepfunctions:ListStateMachineVersions                  |           |
|                            | stepfunctions:ListStateMachineAliases                   |           |
|                            | stepfunctions:ListTagsForResource                       |           |
|                            | stepfunctions:GetActivityTask                           |           |
|                            | stepfunctions:GetExecutionHistory                       |           |
|                            | stepfunctions:DescribeActivity                          |           |
|                            | stepfunctions:DescribeExecution                         |           |
|                            | stepfunctions:DescribeMapRun                            |           |
|                            | stepfunctions:DescribeStateMachine                      |           |
|                            | stepfunctions:DescribeStateMachineForExecution          |           |
|                            | stepfunctions:DescribeStateMachineAlias                 |           |
| DOCDB                      | docdb:DescribeCertificates                              |           |
|                            | docdb:DescribeDbClusterParameterGroups                  |           |
|                            | docdb:DescribeDbClusterParameters                       |           |
|                            | docdb:DescribeDbClusterSnapshotAttributes               |           |
|                            | docdb:DescribeDbClusterSnapshots                        |           |
|                            | docdb:DescribeDbClusters                                |           |
|                            | docdb:DescribeDbEngineVersions                          |           |
|                            | docdb:DescribeDbInstances                               |           |
|                            | docdb:DescribeDbSubnetGroups                            |           |
|                            | docdb:DescribeEngineDefaultClusterParameters            |           |
|                            | docdb:DescribeEventCategories                           |           |
|                            | docdb:DescribeEventSubscriptions                        |           |
|                            | docdb:DescribeEvents                                    |           |
|                            | docdb:DescribeGlobalClusters                            |           |
|                            | docdb:DescribeOrderableDbInstanceOptions                |           |
|                            | docdb:DescribePendingMaintenanceActions                 |           |
|                            | docdb:ListTagsForResource                               |           |            