
#----------------------------------------------------------------------------------
#THIS FILE IS FOR CREATING WAF RULES FOR THE APPLICATION LOAD BALANCER
#----------------------------------------------------------------------------------

resource "aws_wafv2_web_acl" "scarlet-witch-WAF" {
  name        = "${var.project_name}-WAF"
  scope       = "REGIONAL" # Must be REGIONAL for ALB
  description = "scarlet-witch-WAF for Application Load Balancer"

  default_action {
    allow {}
  }

  #----------------------------------------------------------------------------------
  # AWS Managed Rules – IP Reputation List
  #----------------------------------------------------------------------------------

  rule {
    name     = "AWSManagedRulesAmazonIpReputationList"
    priority = 1

    override_action {
      count {} # Observe only, no blocking
      # block {} # If you want to actively block
      # none {} # Actually enforces the rule
    }

    statement {
      managed_rule_group_statement {
        vendor_name = "AWS"
        name        = "AWSManagedRulesAmazonIpReputationList"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "IpReputationMetric"
      sampled_requests_enabled   = true
    }
  }

  #----------------------------------------------------------------------------------
  # Rate-limiting rule
  #----------------------------------------------------------------------------------

  rule {
    name     = "RateLimitRule"
    priority = 2

    action {
      block {}
    }

    statement {
      rate_based_statement {
        limit              = 3000
        aggregate_key_type = "IP"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "RateLimitMetric"
      sampled_requests_enabled   = true
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "WebACLMetric"
    sampled_requests_enabled   = true
  }
}


#----------------------------------------------------------------------------------
# ASSOCIATE WAF RULE TO LOAD BALANCER
#----------------------------------------------------------------------------------

resource "aws_wafv2_web_acl_association" "doctor-strange-association" {
  resource_arn = aws_lb.alb.arn
  web_acl_arn  = aws_wafv2_web_acl.scarlet-witch-WAF.arn
}


