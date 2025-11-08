resource "random_id" "randomness" {
  byte_length = 16
}

resource "aws_s3_bucket" "my_s3_bucket" {
  bucket = "my-new-bucket-${random_id.randomness.hex}"
  region = "us-east-1"

  force_destroy = true

  tags = {
    Name    = "My S3 bucket"
    Purpose = "Intro to Resource Block Lab"
  }
}
