<a href="https://lacework.com"><img src="https://techally-content.s3-us-west-1.amazonaws.com/public-content/lacework_logo_full.png" width="600"></a>

# terraform-aws-config

[![GitHub release](https://img.shields.io/github/release/lacework/terraform-aws-config.svg)](https://github.com/lacework/terraform-aws-config/releases/)
[![CircleCI status](https://circleci.com/gh/lacework/terraform-aws-config.svg?style=shield)](https://circleci.com/gh/lacework/terraform-aws-config)

Terraform module for configuring an integration with Lacework and AWS for cloud resource configruation assessment.

**NOTE:** To configure both an AWS CloudTrail integration to analyze CloudTrail activity for monitoring cloud account
security and an AWS Config integration to analyze AWS configuration compliance, follow the procedure provided in
[AWS Config and CloudTrail Integration with Terraform](https://support.lacework.com/hc/en-us/articles/360057092034-AWS-Config-and-CloudTrail-Integration-with-Terraform).

## Requirements

* **AWS Account Admin** - The account used to run Terraform must have administrative privileges on every AWS account
you intend to integrate with Lacework.
* **AWS CLI** - The Terraform Provider for AWS leverages the configuration from the AWS CLI and it is recommended the
AWS CLI is [installed and configured](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html) with Access
Keys for the account being integrated.
* **Lacework Administrator** - You must have Lacework account with administrator privileges.
* **Lacework CLI** - The Terraform Provider for Lacework leverages the configuration from the Lacework CLI. It is recommended the Lacework CLI is [installed and configured](https://github.com/lacework/go-sdk/wiki/CLI-Documentation#configuration).
* **Terraform** - `>= 0.12.24`, `~> 0.13.0`.


## Default Settings

This module is prepared to run without any customization, by using the module defaults a cross-account IAM role will
be created to provide Lacework access to monitor AWS resource configurations.

* On a new directory, create a `main.tf` with the following snippet:

```hcl
provider "aws" {}

provider "lacework" {}

module "aws_config" {
  source  = "lacework/config/aws"
  version = "~> 0.1.0"
}
```

* Then, run `terraform init` to initialize the project and download the required modules.
* Run `terraform plan` to validate the configuration and review pending changes.
* When you have reviewed the pending changes run `terraform apply` to execute changes.

To validate that the integration was configured correctly, run the command
`lacework integrations list` you should see a new `AWS_CFG` integration listed.

For more examples look at the [Terraform Registry Examples](https://registry.terraform.io/modules/lacework/config/aws/latest).
