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

variable "variable_sub_cidr_block" {
  default = "10.0.0.0/16"

}

variable "variables_sub_auto_ip" {
  description = "Set Automatic IP Assignment for Variables Subnet"
  type        = bool
  default     = true
}

variable "security_group_id" {
  description = "List of security group IDs to assign to the launch template"
  type        = list(string)
}

variable "project_name" {
  default = "mali"
}
