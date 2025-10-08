# tflint-ignore-file: terraform_unused_declarations

locals {
  version_file   = "${abspath(path.module)}/VERSION"
  module_name    = "terraform-aws-config"
  module_version = fileexists(local.version_file) ? file(local.version_file) : ""
}

data "lacework_metric_module" "lwmetrics" {
  name    = local.module_name
  version = local.module_version
}
