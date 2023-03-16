# data "aws_iam_policy_document" "eks_efs_web_identity" {
#   statement {
#     actions = ["sts:AssumeRoleWithWebIdentity"]

#     principals {
#       type        = "Federated"
#       identifiers = ["arn:aws:iam::${var.acc_id}:oidc-provider/oidc.eks.${var.region-code}.amazonaws.com/id/${var.oidc}"]
#     }
#   }
# }


# resource "aws_iam_role" "efs_role" {
#   name = "test_role"

#   # Terraform's "jsonencode" function converts a
#   # Terraform expression result to valid JSON syntax.
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = "sts:AssumeRole"
#         Effect = "Allow"
#         Sid    = ""
#         Principal = {
#           Service = "ec2.amazonaws.com"
#         }
#       },
#     ]
#   })

#   tags = {
#     tag-key = "tag-value"
#   }
# }