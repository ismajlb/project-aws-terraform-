data "aws_ami" "amidID" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-20250821"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"]
}


output "instance_id" {
  description = "AMI ID of Ubuntu instance"
  value       = data.aws_ami.amidID.id

}
