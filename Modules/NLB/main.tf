
# #----------------------------------------------------
# # NETWORK LOAD BALANCER BLOCK and DEPENDECIES
# #----------------------------------------------------

# # Create the Network Load Balancer

# resource "aws_lb" "nlb" {
#   name               = "${var.project_name}-NLB"
#   internal           = false             
#   load_balancer_type = "network"     
#   enable_deletion_protection = false
#   enable_cross_zone_load_balancing = true
#   security_groups    = [var.alb_security_group_id]
#   subnets            = [var.public_subnet_1_id, var.public_subnet_2_id]


#   tags = merge(
#     # 1. The map of common tags from your variable
#     var.resource_tags,

#     # 2. Your specific, hardcoded, or dynamic tags
#     {
#       Name = "${var.project_name}-NLB"
#     }
#   )
# }


# #--------------------------------------
# # Create a Target Group for NLB
# #--------------------------------------

# resource "aws_lb_target_group" "nlb_target_group" {
#   name     = "${var.project_name}-NLB-TG"
#   port     = 80
#   protocol = "TCP"
#   vpc_id   = var.vpc_id

#   health_check {
#     protocol = "TCP"
#     port     = "80"
#   }

#     tags = merge(
#     # 1. The map of common tags from your variable
#     var.resource_tags,

#     # 2. Your specific, hardcoded, or dynamic tags
#     {
#       Name = "${var.project_name}-NLB"
#     }
#   )
# }



# #--------------------------------------
# # Create a Listener for NLB
# #--------------------------------------

# resource "aws_lb_listener" "nlb_tcp_listener" {
#   load_balancer_arn = aws_lb.nlb.arn
#   port              = 80
#   protocol          = "TCP"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.nlb_target_group.arn
#   }
# }



# # resource "aws_lb_target_group_attachment" "attach-auto-scaling-group" {
# #   target_group_arn = aws_lb_target_group.nlb_target_group.arn
# #   target_id        = [aws_lb_target_group.nlb_target_group.arn]
# # }

