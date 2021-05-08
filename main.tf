variable "region" {
  type = string
  default = "ap-southeast-2"
}

variable "keypair_name" {
  type = string
  default = "minecraft"
}

variable "pem_location" {
    type = string
    default = "~/.ssh/server.pem"
}

provider "aws" {
  region = var.region
}

resource "aws_instance" "web" {
  ami           = "ami-0ce84f166e6e3ad45"
  instance_type = "t4g.medium"
  key_name      = var.keypair_name

  vpc_security_group_ids = [aws_security_group.allow_minecraft_port.id, aws_security_group.allow_ssh.id]


  provisioner "file" {
    source      = "bootstrap-server.sh"
    destination = "/home/ec2-user/bootstrap-server.sh"

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file(var.pem_location)
      host        = aws_instance.web.public_ip
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ec2-user/bootstrap-server.sh"
    ]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file(var.pem_location)
      host        = aws_instance.web.public_ip
    }
  }

  root_block_device {
    volume_size = 20
  }

  tags = {
    Name = "Minecraft Server"
  }
}



resource "aws_security_group" "allow_minecraft_port" {
  name        = "allow_minecraft"
  description = "Allow Minecraft inbound traffic"

  ingress {
    description = "SSH traffic"
    from_port   = 25565
    to_port     = 25565
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Allow Minecraft"
  }
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"

  ingress {
    description = "SSH traffic"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "HTTPS outbound traffic"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Allow ssh"
  }
}