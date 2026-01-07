
#---------------------------------------------------------------
#This is the resouce block for load balancer for module
#---------------------------------------------------------------
resource "aws_lb" "alb" {
  name               = "${var.project_name}-ALB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_security_group_id]
  subnets            = [var.public_subnet_1_id, var.public_subnet_2_id]

  # ------------------------------
  # ENABLE ACCESS LOGS FOR LOAD BALANCER HERE
  # ------------------------------
  access_logs {
    enabled = true
    bucket  = aws_s3_bucket.alb_log_bucket.id

  }

  depends_on = [
    aws_s3_bucket_policy.alb-log-bucket-policy
  ]

  tags = merge(
    # 1. The map of common tags from your variable
    var.resource_tags,

    # 2. Your specific, hardcoded, or dynamic tags
    {
      Name = "${var.project_name}-ALB"
    }
  )
}


#---------------------------------------
# LISTENER CONFIGURATION
#---------------------------------------
resource "aws_lb_listener" "alb_http_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_target_group.arn
  }
}


#---------------------------------------------------------------
# TARGET GROUP
#---------------------------------------------------------------
resource "aws_lb_target_group" "alb_target_group" {
  name     = "${var.project_name}-ALB-TG"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id


  health_check {
    enabled             = true
    interval            = 30
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = merge(
    # 1. The map of common tags from your variable
    var.resource_tags,

    # 2. Your specific, hardcoded, or dynamic tags
    {
      Name = "${var.project_name}-target-group-for-alb"
    }
  )
}


resource "aws_lb_target_group_attachment" "attach-Web-1" {
  target_group_arn = aws_lb_target_group.alb_target_group.arn
  target_id        = var.aws_instance_id1
}

resource "aws_lb_target_group_attachment" "attach-Web-2" {
  target_group_arn = aws_lb_target_group.alb_target_group.arn
  target_id        = var.aws_instance_id2
}
