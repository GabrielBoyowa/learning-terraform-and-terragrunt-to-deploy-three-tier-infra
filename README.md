Project: Three-Tier Web Application on AWS (Terraform Setup)

This repository holds the Infrastructure as Code (IaC) for deploying a foundational three-tier web application architecture on AWS using Terraform.

1. Architecture Overview (Current State)

This setup provides a resilient, highly available foundation across two Availability Zones (AZs). It currently deploys the Network Tier (VPC, IGW, and Security Groups) and the Presentation/Application Tier. The foundation includes 2 public subnets for the Application Load Balancer (ALB) and 2 private subnets hosting the two EC2 Instances, which run a simple web server. The ALB is responsible for distributing incoming HTTP traffic, and Security Groups control the ingress/egress traffic flow. The Data Tier (RDS) is planned for future integration.

2. Prerequisites

You will need the following tools configured locally:

AWS CLI: Configured with necessary credentials.

Terraform: Version 1.0 or higher.

3. Deployment

Follow this sequence to deploy the infrastructure:

Initialize the backend: terraform init

Review the execution plan: terraform plan

Deploy the infrastructure: terraform apply (confirm with yes)

Access the app using the alb_dns_name output URL.

# Example Output:
# alb_dns_name = "three-tier-app-alb-123456789.us-east-1.elb.amazonaws.com"



4. Cleanup

To destroy all deployed AWS resources and avoid charges:

terraform destroy



5. Future Roadmap

5.1. Database Integration (RDS)

Goal: Integrate a Multi-AZ RDS instance (Data Tier) into the private subnets.

Action: Configure security groups to allow traffic only from EC2 to RDS on the database port.

5.2. Terragrunt Migration

Goal: Refactor IaC to Terragrunt for module reuse and simplified multi-environment management.

Action: Implement terragrunt.hcl to manage remote state, dependencies, and environment variables.
