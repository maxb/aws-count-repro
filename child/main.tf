variable "iam_policy_json" {}
variable "should_create_iam_group" { default = false }
variable "iam_group_assume_role_arns" { default = null }
variable "should_require_mfa" {}

data "aws_iam_policy_document" "managed_policy" {
  count = ((var.should_create_iam_group && var.iam_group_assume_role_arns != null) || length(var.iam_policy_json) > 0 || var.should_require_mfa) ? 1 : 0
}
