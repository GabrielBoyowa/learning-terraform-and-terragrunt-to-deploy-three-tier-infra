#This is the block of code for two instances and data base

data "aws_ami" "web_ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel*"]
  }
}

data "aws_availability_zones" "availability_zones" {}




resource "aws_instance" "Web-1" {
  ami                         = data.aws_ami.web_ami.id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = var.public_subnet_1_id
  availability_zone           = data.aws_availability_zones.availability_zones.names[0]
  associate_public_ip_address = true
  security_groups             = [var.web_server_security_group_id]
  user_data                   = var.user_data

  tags = {
    Name = "${var.project_name}-Web-Server-1"

  }
}

resource "aws_instance" "Web-2" {
  ami                         = data.aws_ami.web_ami.id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = var.public_subnet_2_id
  availability_zone           = data.aws_availability_zones.availability_zones.names[1]
  associate_public_ip_address = true
  security_groups             = [var.web_server_security_group_id]
  user_data                   = var.user_data

  tags = {
    Name = "${var.project_name}-Web-Server-2"

  }
}
