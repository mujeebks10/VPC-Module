# VPC
output "vpc_id" {
  value       = aws_vpc.my_three_tier_vpc.id
  description = "The ID of the created VPC"
}

# Subnets
output "web_subnet_ids" {
  value       = [for s in aws_subnet.web : s.id]
  description = "List of web (public) subnet IDs"
}

output "app_subnet_ids" {
  value       = [for s in aws_subnet.app : s.id]
  description = "List of app (private) subnet IDs"
}

output "db_subnet_ids" {
  value       = [for s in aws_subnet.db : s.id]
  description = "List of DB subnet IDs"
}

# NAT Gateways
output "nat_gateway_ids" {
  value = [
    aws_nat_gateway.web_tier1.id,
    aws_nat_gateway.web_tier2.id
  ]
  description = "List of NAT Gateway IDs"
}

# Internet Gateway
output "internet_gateway_id" {
  value       = aws_internet_gateway.my_three_tier_igw.id
  description = "Internet Gateway ID"
}
