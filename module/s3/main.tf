
# CREATE S3 BUCKET WITH POLICIES

resource "aws_s3_bucket" "terraform_s3" {
  bucket = "my-terraform-project-aug-2024" # Replace with your unique bucket name
  
  tags = {
    Name        = "Terraform State Bucket"
    Environment = "Dev"
  }
}

# resource "aws_s3_bucket_acl" "terraform_acl" {
#   bucket = aws_s3_bucket.terraform_s3.id
#   acl    = "private"
# }

resource "aws_s3_bucket_versioning" "s3_versioning" {
  bucket = aws_s3_bucket.terraform_s3.id
  versioning_configuration {
    status = "Enabled"
  }
}

