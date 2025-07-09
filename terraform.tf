
terraform {
  cloud {
    organization = "Lennar"
    workspaces {
      name = "terraform-control-workspace"
    }
  }
}