locals {
  environments = [
    for env, config in var.environment_config :
    env if config.cloud == "aws" || config.cloud == "azure"
  ]
}
module "landing_zone_core" {
  source  = "app.terraform.io/Lennar/landing-zone-core/tfe"
  version = "1.1.4"

  tfe_organization    = "Lennar"
  project_name        = "${var.app_acronym}-${var.app_name}"
  github_organization = var.gh_org
  TF_API_TOKEN        = var.TF_API_TOKEN
  github_configs = {

    "${var.repo_suffix}" = {
      github_environments   = local.environments
      visibility            = "private"
      template_organization = "${var.template_organization}"
      template_repository   = "${var.template_repository}"
      collaborators = [
        {
          team_id    = "${var.gh_team}"
          permission = "${var.gh_permission}"
        }
      ]
    }
  }


  workspace_configs = {
    for env, config in var.environment_config :
    env => config.cloud == "aws" ? {
      aws_account_id               = config.aws_account
      subscription_id              = null
      sentinel_policy_enforce_mode = "soft-mandatory"
      variables = [
        {
          key         = "TFC_AWS_PROVIDER_AUTH"
          value       = "true"
          category    = "env"
          description = "Terraform Cloud AWS Provider Authentication"
          sensitive   = false
        },
        {
          key         = "TFC_VAULT_PROVIDER_AUTH"
          value       = "true"
          category    = "env"
          description = "Vault Provider Authentication"
          sensitive   = false
        }
      ]
    } :
    { aws_account_id               = null
      subscription_id              = config.subscription_id
      sentinel_policy_enforce_mode = "soft-mandatory"
      variables = [
        {
          key         = "TFC_AZURE_PROVIDER_AUTH"
          value       = "true"
          category    = "env"
          description = "Terraform Cloud Azure Provider Authentication"
          sensitive   = false
        }
      ]
    }
  }
}


