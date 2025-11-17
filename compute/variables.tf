variable "ami_id" {
  description = "AMI ID to use for launch template"
  type        = string
}

variable "security_group_ids" {
  description = "List of Security Group IDs for instances"
  type        = list(string)
}

variable "subnet_ids" {
  description = "List of subnet IDs for the ASG"
  type        = list(string)
}
