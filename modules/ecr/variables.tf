variable "repository_names" {
  description = "ECR repository names"
  type        = list(string)
}

variable "image_tag_mutability" {
  description = "Image tag mutability"
  type        = string
  default     = "MUTABLE"
}

variable "scan_on_push" {
  description = "Scan on push"
  type        = bool
  default     = true
}

variable "environment" {
  description = "Environment name"
  type        = string
}
