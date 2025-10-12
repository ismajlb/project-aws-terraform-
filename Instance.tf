data "aws_ami" "amiID" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "web" {
  ami                    = var.amiID[var.region]
  instance_type          = "t3.micro"
  key_name               = "mali-key"
  vpc_security_group_ids = [aws_security_group.mali-sg.id]
  availability_zone      = var.zone1
  subnet_id              = aws_subnet.mali-pub-1.id

  tags = {
    Name    = "Emri i Instances"
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
  instance_id = aws_instance.web.id
  state       = "running"

}

output "WebPublicIP" {
  description = "AMI ID of Linux Amazon"
  value       = aws_instance.web.public_ip

}

output "WebPrivateIP" {
  description = "AMI ID of Linux Amazon"
  value       = aws_instance.web.private_ip

}
