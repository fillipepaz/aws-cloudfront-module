resource "aws_s3_bucket" "bucket" {
  bucket = var.bucketName

  tags = {
    Name = var.bucketName
    Project = var.project
  }
}

resource "aws_s3_bucket_acl" "b_acl" {
  bucket = aws_s3_bucket.bucket.id
  acl    = "private"
}