output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.this.id
}

output "public_subnet_id" {
  description = "Public subnet ID"
  value       = aws_subnet.public.id
}

output "private_subnet_id" {
  description = "Private subnet ID"
  value       = aws_subnet.private.id
}

output "nat_gateway_id" {
  description = "NAT Gateway ID"
  value       = aws_nat_gateway.this.id
}

output "internet_gateway_id" {
  description = "Internet Gateway ID"
  value       = aws_internet_gateway.this.id
}

output "vpc_peering_connection_id" {
  description = "VPC Peering Connection ID"
  value       = aws_vpc_peering_connection.this.id
}

output "vpc_endpoint_ids" {
  description = "VPC Endpoint IDs"
  value       = [aws_vpc_endpoint.s3.id, aws_vpc_endpoint.dynamodb.id]
}
output "ec2_vpc_endpoint_id" {
  description = "EC2 VPC Endpoint ID"
  value       = aws_vpc_endpoint.ec2.id
}
