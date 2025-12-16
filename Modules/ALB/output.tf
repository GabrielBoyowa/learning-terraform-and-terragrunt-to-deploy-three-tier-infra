
#-----------------------------------------------
#This is the output block for my company module
#-----------------------------------------------


output "alb_target_group_arn" {
  value = aws_lb_target_group.alb_target_group.arn
}

output "waf_logs_bucket" {
  value = aws_s3_bucket.waf_logs_bucket.arn
}

output "application_load_balancer_dns_name" {
  value = aws_lb.alb.dns_name
}

output "web_acl_arn" {
  value = aws_wafv2_web_acl.scarlet-witch-WAF.arn
}


# output "application_load_balancer_zone_id" {
#   value = aws_lb.application_load_balancer.zone_id
# }