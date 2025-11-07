variable "region" {
  default = "eu-central-1"
}

variable "zone1" {
  default = "eu-central-1a"
}

variable "zone2" {
  default = "eu-central-1b"
}

variable "webuser" {
  default = "ec2-user"
}

variable "amiID" {
  type = map(string)
  default = {
    "eu-central-1" = "ami-08697da0e8d9f59ec"
    "eu-west-1"    = "ami-04f25a69b566c844b"
  }
}

variable "project_name" {
  default = "mali"
}
