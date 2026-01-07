#This is the output file for my company ec2 module

output "aws_instance_id1" {
  value = aws_instance.Web-1.id
}

output "aws_instance_id2" {
  value = aws_instance.Web-2.id
}

output "public_ip1" {
  value = aws_instance.Web-1.public_ip
}

output "public_ip2" {
  value = aws_instance.Web-2.public_ip
}

# output "launch_template_id" {
#   description = "ID of the EC2 launch template used by the ASG"
#   value       = aws_launch_template.auto_scaling_launch_template.id
# }

# output "launch_template_name" {
#   description = "Name of the EC2 launch template"
#   value       = aws_launch_template.auto_scaling_launch_template.name
# }

# output "autoscaling_group_name" {
#   description = "Name of the Auto Scaling Group"
#   value       = aws_autoscaling_group.asg.name
# }

# output "autoscaling_group_arn" {
#   description = "ARN of the Auto Scaling Group"
#   value       = aws_autoscaling_group.asg.arn
# }
