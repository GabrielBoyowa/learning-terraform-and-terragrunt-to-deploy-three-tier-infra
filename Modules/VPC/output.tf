#This is the output file for my company module

output "provider_region" {
  value = var.provider_region
}
output "project_name" {
  value = var.project_name
}
output "vpc_id" {
  value = aws_vpc.vpc.id
}
output "public_subnet_1_id" {
  value = aws_subnet.public_subnet_1.id
}
output "public_subnet_2_id" {
  value = aws_subnet.public_subnet_2.id
}
output "private_subnet_1_id" {
  value = aws_subnet.private_subnet_1.id
}
output "private_subnet_2_id" {
  value = aws_subnet.private_subnet_2.id
}
output "DB_private_subnet_1_id" {
  value = aws_subnet.DB_private_subnet_1.id
}
output "DB_private_subnet_2_id" {
  value = aws_subnet.DB_private_subnet_2.id
}
output "internet_gateway" {
  value = aws_internet_gateway.internet_gateway
}
