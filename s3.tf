resource "random_id" "randomness" {
  byte_length = 16
}

resource "aws_s3_bucket" "my_s3_bucket" {
  bucket = "my-new-bucket-${random_id.randomness.hex}"
  region = "eu-central-1"

  force_destroy = true

  tags = {
    Name    = "My S3 bucket"
    Purpose = "Intro to Resource Block Testing"
  }
}


resource "aws_vpc_endpoint" "s3" {
  vpc_id       = aws_vpc.second_vpc.id
  service_name = "com.amazonaws.eu-central-1.s3"

  tags = {
    Environment = "testing env"
  }
}
