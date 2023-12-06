terraform {
  required_version = "~> 1.6"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.25"
    }
  }
}

provider "aws" {
  region = var.region
}


data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "my-first-instance" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t4g.medium"
  vpc_security_group_ids = [aws_security_group.sg_web.id]

  key_name = "learn_devops"

  tags = {
    Name = "terraform-learning"
  }
}

resource "aws_security_group" "sg_web" {
  name = "sg_web"
  // connectivity to ubuntu mirrors is required to run `apt-get update` and `apt-get install apache2`

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["14.248.83.170/32", "118.70.80.24/32"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
