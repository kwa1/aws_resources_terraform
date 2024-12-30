

output "alb_dns_name" {
  value = module.alb.lb_dns_name
}

output "asg_id" {
  value = module.asg.asg_id
}

output "route53_zone_id" {
  value = module.route53.route53_zone_id
}

output "subdomain_records" {
  value = module.route53.subdomain_records
}
