resource "aws_s3_bucket" "osrs_lambdas" {
  bucket = "osrs-lambdas"

  tags = {
    project = "osrs"
  }
}

resource "aws_s3_bucket_acl" "osrs_lambdas_acl" {
  bucket = aws_s3_bucket.osrs_lambdas.id
  acl    = "private"
}
