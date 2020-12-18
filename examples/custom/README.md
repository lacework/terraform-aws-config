# AWS Config Integration (Custom Settings)

This module is prepared to run without any customization, by using the module defaults a
cross-account IAM role will be created to provide Lacework access to monitor AWS resource
configurations.

## Requirements

* **AWS Account Admin** - The account used to run Terraform must have administrative privileges on every AWS account
you intend to integrate with Lacework.
* **AWS CLI** - The Terraform Provider for AWS leverages the configuration from the AWS CLI and it is recommended the
AWS CLI is [installed and configured](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html) with Access
Keys for the account being integrated.
* **Lacework Administrator** - You must have Lacework account with administrator privileges.
* **Lacework CLI** - The Terraform Provider for Lacework leverages the configuration from the Lacework CLI. It is recommended the Lacework CLI is [installed and configured](https://github.com/lacework/go-sdk/wiki/CLI-Documentation#configuration).
* **Terraform** - `>= 0.12.24`, `~> 0.13.0`.

## Deployment

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
`lacework integrations list`, you should see a new `AWS_CFG` integration listed.
