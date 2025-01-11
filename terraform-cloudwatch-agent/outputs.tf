output "instance_id" {
  description = "ID of the created EC2 instance"
  value       = aws_instance.cw_agent_instance.id
}

output "instance_public_ip" {
  description = "Public IP of the created EC2 instance"
  value       = aws_instance.cw_agent_instance.public_ip
}
