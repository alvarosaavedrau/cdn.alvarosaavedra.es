resource "aws_s3_bucket" "s3" {
  bucket = var.domain_name
}

resource "aws_s3_bucket_public_access_block" "s3" {
  bucket = aws_s3_bucket.s3.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  depends_on = [aws_s3_bucket.s3]
}

resource "aws_s3_bucket_policy" "s3CDN" {
  bucket = var.domain_name
  policy = data.aws_iam_policy_document.s3CDNPolicy.json

  depends_on = [aws_s3_bucket.s3]
}