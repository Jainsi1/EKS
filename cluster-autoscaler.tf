data "aws_iam_policy_document" "clusterautoscaler-role-policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "Federated"
      identifiers = ["${module.eks.oidc_provider_arn}"]
    }
    actions = ["sts:AssumeRoleWithWebIdentity"]
    condition {
      test = "StringEquals"

      values = ["sts.amazonaws.com"]
      variable = "${module.eks.oidc_provider}:aud" 
    }
    condition {
      test = "StringEquals"

      # values = ["system:serviceaccount:default:${iam.serviceaccount}"]
      values = ["system:serviceaccount:kube-system:cluster-autoscaler"]
      variable = "${module.eks.oidc_provider}:sub" 
    }
  }
}
resource "aws_iam_policy" "cluster-autoscaler-policy" {
  name = "${module.eks.cluster_name}-cluster-autoscaler-policy"

  policy = file("./autoscaler-policy.json")
}

resource "aws_iam_role" "cluster-autoscaler-role" {
  name = "${module.eks.cluster_name}-cluster-autoscaler-role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = data.aws_iam_policy_document.clusterautoscaler-role-policy.json
}
resource "aws_iam_role_policy_attachment" "cluster-autoscaler-attach" {
  role       = aws_iam_role.cluster-autoscaler-role.name
  policy_arn = aws_iam_policy.cluster-autoscaler-policy.arn
}