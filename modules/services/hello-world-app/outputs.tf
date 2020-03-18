output "asg_name" {
  value       = module.asg.asg_name
  description = "The name of the Auto Scaling Group"
}

output "instance_security_group_id" {
  value       = module.asg.instance_security_group_id
  description = "The ID of the EC2 Instance Security Group"
}

output "alb_security_group_id" {
  value = module.alb.alb_security_group_id
}

output "alb_dns_name" {
  value = module.alb.alb_dns_name
}
