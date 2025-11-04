#This is the ouput file for security group of my company module 

output "alb_security_group_id" {
  value = aws_security_group.alb_security_group.id
}

output "web_server_security_group_id" {
  value = aws_security_group.web_server_security_group.id
}
