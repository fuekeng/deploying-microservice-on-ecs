module "vpc" {
  source = "./modules/vpc"

  vpc_cidr           = var.vpc_cidr
  environment        = var.environment
  enable_nat_gateway = var.enable_nat_gateway
  single_nat_gateway = var.single_nat_gateway
}

module "ecr" {
  source = "./modules/ecr"

  repository_names = var.ecr_repositories
  environment      = var.environment
}

module "ecs_cluster" {
  source = "./modules/ecs-cluster"

  environment              = var.environment
  enable_container_insights = var.enable_container_insights
}

# CloudMap Namespace for service discovery
resource "aws_service_discovery_private_dns_namespace" "main" {
  name            = "${var.environment}.microservices.local"
  vpc_id          = module.vpc.vpc_id
  description     = "Service discovery namespace for microservices"
  
  tags = {
    Name        = "${var.environment}-microservices-ns"
    Environment = var.environment
  }
}

# ALB for routing
resource "aws_lb" "main" {
  name               = "${var.environment}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = module.vpc.public_subnet_ids

  tags = {
    Name        = "${var.environment}-alb"
    Environment = var.environment
  }
}

resource "aws_security_group" "alb" {
  name        = "${var.environment}-alb-sg"
  description = "Security group for ALB"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.environment}-alb-sg"
    Environment = var.environment
  }
}
