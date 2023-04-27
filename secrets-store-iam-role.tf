data "aws_iam_policy_document" "secret-manager-role-policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "Federated"
      identifiers = ["${module.eks.oidc_provider_arn}"]
    }
    actions = ["sts:AssumeRoleWithWebIdentity"]
  }
}
resource "aws_iam_policy" "secret-manager-policy" {
  name = "${module.eks.cluster_name}-secret-manager-policy"

  policy = file("./secret-manager-policy.json")
}

resource "aws_iam_role" "secret-manager-role" {
  name = "${module.eks.cluster_name}-secret-manager-role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = data.aws_iam_policy_document.secret-manager-role-policy.json
}
resource "aws_iam_role_policy_attachment" "secret-manager-attach" {
  role       = aws_iam_role.secret-manager-role.name
  policy_arn = aws_iam_policy.secret-manager-policy.arn
}