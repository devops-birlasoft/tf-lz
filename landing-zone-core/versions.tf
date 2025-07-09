terraform {
  required_version = ">= 1.0"

  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "~> 3.15.0"
    }

    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0.0"
    }

    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }

    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.40"
    }
  }
}