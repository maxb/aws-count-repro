provider "aws" {}

data "aws_iam_policy_document" "role_policy" {
  statement {
    sid    = "AWSVPCFlowLogs"
    effect = "Allow"

    resources = ["*"]

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams"
    ]
  }
}

variable "publish_flow_log_to_cloud_watch" { default = true }
variable "use_managed_iam_policies" { default = true }

module "role" {
  source = "./child"

  count = var.publish_flow_log_to_cloud_watch ? 1 : 0

  should_require_mfa = false

  iam_policy_json = var.use_managed_iam_policies ? data.aws_iam_policy_document.role_policy.json : ""
}
