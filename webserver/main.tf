terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.27"
    }
  }

  required_version = ">=0.14"
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

data "aws_ami" "latest_amazon_linux" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "public_servers" {
  count             =       length(var.public_subnet_ids)
  ami                         = data.aws_ami.latest_amazon_linux.id
  instance_type               = lookup(var.instance_type, var.env)
  key_name                    = var.key_name
  security_groups             = var.public_sgs_ids
  subnet_id                   = var.public_subnet_ids[count.index]
  associate_public_ip_address = true

  user_data = count.index >= 2 ? null : templatefile("${path.module}/install_httpd.sh.tpl",
    {
      env    = upper(var.env)
    }
  )

  tags = merge(var.default_tags,
    {
      "Name" = "${var.prefix}-public-vm-${count.index}"
    }
  )
}

resource "aws_instance" "private_servers" {
  count             =       length(var.private_subnet_ids)
  ami                         = data.aws_ami.latest_amazon_linux.id
  instance_type               = lookup(var.instance_type, var.env)
  key_name                    = var.key_name
  security_groups             = var.private_sgs_ids
  subnet_id                   = var.private_subnet_ids[count.index]
  associate_public_ip_address = false
  tags = merge(var.default_tags,
    {
      "Name" = "${var.prefix}-private-vm-${count.index}"
    }
  )
}