output "external_id" {
  value       = local.iam_role_external_id
  description = "The External ID configured into the IAM role"
}

output "iam_role_name" {
  value       = local.iam_role_name
  description = "The IAM Role name"
}

output "iam_role_arn" {
  value       = local.iam_role_arn
  description = "The IAM Role ARN"
}

output "lacework_audit_policy_name" {
  value     = local.lacework_audit_policy_name
  description = "The name of the custom audit policy (which extends SecurityAudit) to allow Lacework to read configs"
}
