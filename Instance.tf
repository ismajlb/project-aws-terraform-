data "aws_ami" "amiID" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "app" {
  count                  = 2
  ami                    = var.amiID[var.region]
  instance_type          = "t3.micro"
  key_name               = "mali-key"
  vpc_security_group_ids = [aws_security_group.mali-sg.id]
  availability_zone      = count.index == 0 ? var.zone1 : var.zone2
  subnet_id              = count.index == 0 ? aws_subnet.subnet-pub-1.id : aws_subnet.subnet-pub-2.id



  tags = {
    Name    = "name_of_instance"
    Project = "Test Project"
  }

  provisioner "file" {
    source      = "web.sh"
    destination = "/tmp/web.sh"
  }

  connection {
    type        = "ssh"
    user        = var.webuser
    private_key = file("malikey")
    host        = self.public_ip
  }

  provisioner "remote-exec" {

    inline = [
      "chmod +x /tmp/web.sh",
      "sudo /tmp/web.sh"
    ]
  }

  provisioner "local-exec" {

    command = "echo ${self.private_ip} >> private_ips.txt"
  }

}

resource "aws_ec2_instance_state" "web-state" {
  count       = 2
  instance_id = aws_instance.app[count.index].id
  state       = "running"
}

output "WebPublicIP" {
  description = "AMI ID of Linux Amazon"
  value       = [for i in aws_instance.app : i.public_ip]
}

output "WebPrivateIP" {
  description = "AMI ID of Linux Amazon"
  value       = [for i in aws_instance.app : i.private_ip]
}

