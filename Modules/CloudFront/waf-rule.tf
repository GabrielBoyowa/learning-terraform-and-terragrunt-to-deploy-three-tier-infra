


#----------------------------------------------------------------------------------
#THIS BLOCK IS FOR CREATING WAF RULES FOR CLOUDFRONT DISTRIBUTION
#----------------------------------------------------------------------------------

resource "aws_wafv2_web_acl" "waf-rule-CDN" {
  name        = "${var.project_name}-CDN-WAF"
  scope       = "CLOUDFRONT"
  description = "WAF Rule configuration for Cloud Front Distribution"

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