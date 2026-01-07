
#---------------------------------------------------------------
#This is the block of code for two instances 
#---------------------------------------------------------------

data "aws_ami" "web_ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel*"]
  }
}

data "aws_availability_zones" "availability_zones" {}

#---------------------------------------------------------------
# WEBSERVERS
#---------------------------------------------------------------

resource "aws_instance" "Web-1" {
  ami                         = data.aws_ami.web_ami.id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = var.public_subnet_1_id
  availability_zone           = data.aws_availability_zones.availability_zones.names[0]
  associate_public_ip_address = true
  security_groups             = [var.web_server_security_group_id]
  user_data                   = var.user_data


  tags = merge(
    # 1. The map of common tags from your variable
    var.resource_tags,

    # 2. Your specific, hardcoded, or dynamic tags
    {
      Name = "${var.project_name}-Web-Server-1"
    }
  )
}
resource "aws_instance" "Web-2" {
  ami                         = data.aws_ami.web_ami.id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = var.public_subnet_2_id
  associate_public_ip_address = true
  security_groups             = [var.web_server_security_group_id]
  user_data                   = var.user_data

  tags = merge(
    # 1. The map of common tags from your variable
    var.resource_tags,

    # 2. Your specific, hardcoded, or dynamic tags
    {
      Name = "${var.project_name}-Web-Server-2"
    }
  )
}




# #---------------------------------------------------------------
# #This is the block of code for Auto Scaling Group
# #---------------------------------------------------------------

# # ASG with Launch template
# resource "aws_launch_template" "auto_scaling_launch_template" {
#   name_prefix   = "avengers_ec2_launch_template-${var.project_name}"
#   image_id      = data.aws_ami.web_ami.id 
#   instance_type = var.instance_type
#   user_data     = var.user_data

#   network_interfaces {
#     associate_public_ip_address = true
#     subnet_id                   = var.public_subnet_2_id
#     security_groups             = [var.web_server_security_group_id]
#   }
#   tags = merge(
#     # 1. The map of common tags from your variable
#     var.resource_tags,

#     # 2. Your specific, hardcoded, or dynamic tags
#     {
#       Name = "${var.project_name}-ASG"
#     }
#   )
# }

# resource "aws_autoscaling_group" "asg" {
#   # no of instances
#   desired_capacity = 2
#   max_size         = 4
#   min_size         = 1
#   # availability_zones = [data.aws_availability_zones.availability_zones.names[0], data.aws_availability_zones.availability_zones.names[1]]



#   # Connect to the target group
#   # target_group_arns = [aws_lb_target_group.nlb_target_group.arn]

#   vpc_zone_identifier = [data.aws_availability_zones.availability_zones.names[0], data.aws_availability_zones.availability_zones.names[1]]


#   launch_template {
#     id      = aws_launch_template.auto_scaling_launch_template.id
#     version = "$Latest"
#   }
# }