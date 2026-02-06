terraform {
  backend "s3" {
    # Configuration is provided via backend config file during init
    # Example: terraform init -backend-config=dev/backend.tfvars
  }
}
