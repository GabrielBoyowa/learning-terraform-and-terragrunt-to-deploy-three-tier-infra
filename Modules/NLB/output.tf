
# #-----------------------------------------------
# # This is the output block for network load balancer module
# #-----------------------------------------------

# output "alb_target_group_arn" {
#   value = aws_lb_target_group.nlb_target_group.arn
# }

# output "nlb_dns_name" {
#   description = "The DNS name of the Network Load Balancer"
#   value       = aws_lb.nlb.dns_name
# }

# # output "target_attachment_id" {
# #   value = aws_lb_target_group_attachment.attach-auto-scaling-group.id
# # }

# output "target_group_arn" {
#   description = "The ARN of the Target Group"
#   value       = aws_lb_target_group.nlb_target_group.arn
# }

# output "listener_arn" {
#   description = "The ARN of the Listener"
#   value       = aws_lb_listener.nlb_tcp_listener.arn
# }
