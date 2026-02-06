output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "private_subnet_ids" {
  description = "Private subnet IDs"
  value       = module.vpc.private_subnet_ids
}

output "public_subnet_ids" {
  description = "Public subnet IDs"
  value       = module.vpc.public_subnet_ids
}

output "ecr_repository_urls" {
  description = "ECR repository URLs"
  value       = module.ecr.repository_urls
}

output "ecs_cluster_id" {
  description = "ECS Cluster ID"
  value       = module.ecs_cluster.cluster_id
}

output "ecs_cluster_name" {
  description = "ECS Cluster name"
  value       = module.ecs_cluster.cluster_name
}

output "cloudmap_namespace_id" {
  description = "CloudMap namespace ID"
  value       = aws_service_discovery_private_dns_namespace.main.id
}

output "alb_dns_name" {
  description = "ALB DNS name"
  value       = aws_lb.main.dns_name
}

output "alb_arn" {
  description = "ALB ARN"
  value       = aws_lb.main.arn
}

output "alb_security_group_id" {
  description = "ALB security group ID"
  value       = aws_security_group.alb.id
}
