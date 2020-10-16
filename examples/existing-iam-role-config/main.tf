provider "lacework" { }

provider "aws" { }

module "aws_config" {
	source                    = "../../"
	use_existing_iam_role     = true
	iam_role_arn              = "arn:aws:iam::123456789012:role/lw-existing-role"
	iam_role_name             = "lw-existing-role"
	iam_role_external_id      = "H12d0TE22ab"
	lacework_integration_name = "account-abc"
}
