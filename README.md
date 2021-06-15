<a href="https://lacework.com"><img src="https://techally-content.s3-us-west-1.amazonaws.com/public-content/lacework_logo_full.png" width="600"></a>

# terraform-aws-config

[![GitHub release](https://img.shields.io/github/release/lacework/terraform-aws-config.svg)](https://github.com/lacework/terraform-aws-config/releases/)
[![Codefresh build status]( https://g.codefresh.io/api/badges/pipeline/lacework/terraform-modules%2Ftest-compatibility?type=cf-1&key=eyJhbGciOiJIUzI1NiJ9.NWVmNTAxOGU4Y2FjOGQzYTkxYjg3ZDEx.RJ3DEzWmBXrJX7m38iExJ_ntGv4_Ip8VTa-an8gBwBo)]( https://g.codefresh.io/pipelines/edit/new/builds?id=607e25e6728f5a6fba30431b&pipeline=test-compatibility&projects=terraform-modules&projectId=607db54b728f5a5f8930405d)

Terraform module for configuring an integration with Lacework and AWS for cloud resource configruation assessment.

## Inputs

| Name                      | Description                                                                                                        | Type          | Default          | Required |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------ | ------------- | ---------------- | :------: |
| external_id_length        | The length of the external ID to generate. Max length is 1224. Ignored when use_existing_iam_role is set to `true` | `number`      | `16`             |    no    |
| iam_role_arn              | The IAM role ARN is required when setting use_existing_iam_role to `true`                                          | `string`      | `""`             |    no    |
| iam_role_external_id      | The external ID configured inside the IAM role is required when setting use_existing_iam_role to `true`            | `string`      | `""`             |    no    |
| iam_role_name             | The IAM role name. Required to match with iam_role_arn if use_existing_iam_role is set to `true`                   | `string`      | `""`             |    no    |
| lacework_aws_account_id   | The Lacework AWS account that the IAM role will grant access                                                       | `string`      | `"434813966438"` |    no    |
| lacework_integration_name | The name of the integration in Lacework                                                                            | `string`      | `"TF config"`    |    no    |
| tags                      | A map/dictionary of Tags to be assigned to created resources                                                       | `map(string)` | `{}`             |    no    |
| use_existing_iam_role     | Set this to true to use an existing IAM role                                                                       | `bool`        | `false`          |    no    |
| wait_time                 | Amount of time to wait before the next resource is provisioned                                                     | `string`      | `"10s"`          |    no    |

## Outputs

| Name          | Description                                  |
| ------------- | -------------------------------------------- |
| external_id   | The External ID configured into the IAM role |
| iam_role_arn  | The IAM Role ARN                             |
| iam_role_name | The IAM Role name                            |
