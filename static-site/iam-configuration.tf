resource "aws_iam_policy" "policy" {
  name        = "${var.bucketName}-policy"
  path        = "/"
  description = "${var.bucketName}-policy"

  
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": {
    "Effect": "Allow",
    "Action": "s3:*",
    "Resource": "${aws_s3_bucket.bucket.arn}/"
  }
}
POLICY
}

#### Role to OIDC

resource "aws_iam_role" "role" {
  name = "${var.bucketName}-role"

  
assume_role_policy = <<POLICYROLE

{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Federated": "arn:aws:iam::${var.accountId}:oidc-provider/token.actions.githubusercontent.com"
            },
            "Action": "sts:AssumeRoleWithWebIdentity",
            "Condition": {
                "StringLike": {
                    "token.actions.githubusercontent.com:sub": "repo:${var.repoNameAndOrg}:*"
                },
                "StringEquals": {
                    "token.actions.githubusercontent.com:aud": "sts.amazonaws.com"
                }
            }
        }
    ]
}

POLICYROLE


  tags = {
    project = var.project
  }
}

### Policy Attachment

resource "aws_iam_role_policy_attachment" "policyAttachment" {
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.policy.arn
}