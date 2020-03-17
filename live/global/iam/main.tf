provider "aws" {
  region = "us-east-2"
}

# resource "aws_iam_user" "example" {
#   count = length(var.user_names)
#   name  = var.user_names[count.index]
# }

resource "aws_iam_user" "example" {
  for_each = toset(var.user_names)
  name     = each.value
}

data "aws_iam_policy_document" "cloudwatch_read_only" {
  statement {
    effect = "Allow"
    actions = [
      "cloudwatch:Describe*",
      "cloudwatch:Get*",
      "cloudwatch:List*"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "cloudwatch_read_only" {
  name   = "cloudwatch-read-only"
  policy = data.aws_iam_policy_document.cloudwatch_read_only.json
}

data "aws_iam_policy_document" "cloudwatch_full_access" {
  statement {
    effect    = "Allow"
    actions   = ["cloudwatch:*"]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "cloudwatch_full_access" {
  name   = "cloudwatch-full-access"
  policy = data.aws_iam_policy_document.cloudwatch_full_access.json
}

resource "aws_iam_user_policy_attachment" "petsuri_cloudwatch_full_access" {
  count = var.give_petsuri_cloudwatch_full_access ? 1 : 0

  user       = aws_iam_user.example["Petsuri"].name
  policy_arn = aws_iam_policy.cloudwatch_full_access.arn
}

resource "aws_iam_user_policy_attachment" "petsuri_cloudwatch_read_only" {
  count = var.give_petsuri_cloudwatch_full_access ? 0 : 1

  user       = aws_iam_user.example["Petsuri"].name
  policy_arn = aws_iam_policy.cloudwatch_read_only.arn
}
