variable "region" {
  default = "eu-central-1"
}

variable "subnet_id" {
  default = "subnet-0adaabfe9a5689154"

}

variable "webuser" {
  default = "ec2-user"

}

variable "zone1" {
  default = "eu-central-1a"
}

variable "zone2" {
  default = "eu-central-1b"
}

variable "zone3" {
  default = "eu-central-1c"
}

variable "amiID" {
  type = map(any)
  default = {
    eu-central-1 = "ami-08697da0e8d9f59ec"
    eu-west-1    = "ami-04f25a69b566c844b"
  }
}
