resource "aws_s3_bucket" "my_bucket" {
  bucket = "jenkins-bucket-0000000000"
  tags = {
    Name = "my_bucket_Jenkins"
  }
}

resource "aws_s3_bucket_ownership_controls" "bucket_owner" {
  bucket = aws_s3_bucket.my_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}
resource "aws_s3_bucket_public_access_block" "bucket_access" {
  bucket = aws_s3_bucket.my_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "bucket_acl" {
  depends_on = [
    aws_s3_bucket_ownership_controls.bucket_owner,
    aws_s3_bucket_public_access_block.bucket_access,
  ]

  bucket = aws_s3_bucket.my_bucket.id
  acl    = "public-read"
}

resource "aws_s3_bucket_policy" "my_bucket_policy" {
  bucket = aws_s3_bucket.my_bucket.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::${aws_s3_bucket.my_bucket.id}/*"
    }
  ]
}
EOF
}

resource "aws_s3_object" "object" {
  bucket = aws_s3_bucket.my_bucket.id
  key    = "index.html"
  source = "./static/index.html"
etag = filemd("./static/index.html")
}