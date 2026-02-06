# Récupérer les outputs du root module
data "terraform_remote_state" "root" {
  backend = "s3"

  config = {
    bucket         = "terraform-state"
    key            = "dev/infrastructure/terraform.tfstate"
    region         = var.region
    encrypt        = true
    dynamodb_table = "terraform-locks"
  }
}

# Extraire les valeurs du state du root module
locals {
  vpc_id              = data.terraform_remote_state.root.outputs.vpc_id
  cloudmap_namespace  = data.terraform_remote_state.root.outputs.cloudmap_namespace_id
  alb_security_group  = data.terraform_remote_state.root.outputs.alb_security_group_id
  private_subnets    = data.terraform_remote_state.root.outputs.private_subnet_ids
  public_subnets     = data.terraform_remote_state.root.outputs.public_subnet_ids
}
