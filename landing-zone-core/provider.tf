
provider "tfe" {
  hostname = "app.terraform.io"

}

provider "aws" {
  region = "us-east-1"
}

provider "vault" {
  alias = "vault_admin"
}

provider "github" {
  owner = var.github_organization
}

