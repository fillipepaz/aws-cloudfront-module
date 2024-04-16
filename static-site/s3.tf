resource "aws_s3_bucket" "bucket" {
  bucket = var.bucketName

  tags = {
    Name = var.bucketName
    Project = var.project
  }
}

/*resource "aws_s3_bucket_acl" "b_acl" {
  bucket = aws_s3_bucket.bucket.id
  acl    = "private"
}*/
## BUCKET Policy
resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
  bucket = aws_s3_bucket.bucket.id
  policy = <<POLICY
{
        "Version": "2008-10-17",
        "Id": "PolicyForCloudFrontPrivateContent",
        "Statement": [
            {
                "Sid": "AllowCloudFrontServicePrincipal",
                "Effect": "Allow",
                "Principal": {
                    "Service": "cloudfront.amazonaws.com"
                },
                "Action": "s3:GetObject",
                "Resource": "${aws_s3_bucket.bucket.arn}/*",
                "Condition": {
                    "StringEquals": {
                      "AWS:SourceArn": "arn:aws:cloudfront::${var.accountId}:distribution/${aws_cloudfront_distribution.s3_distribution.id}"
                    }
                }
            }
        ]
      }
POLICY
}

