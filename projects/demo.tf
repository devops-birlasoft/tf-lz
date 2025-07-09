module "demo" {
  source = "../landing-zone-core"

  # App Metadata
  app_acronym     = "dlr"
  app_name        = "lennarConnect"
  app_description = "Lennar Connect Application"

  # GitHub Integration
  gh_org                = "migration-test-len-01"
  gh_team               = "developers"
  gh_permission         = "admin"
  repo_suffix           = "infra-config"
  template_organization = "migration-test-len-01"
  template_repository   = "template-terraform-infra-config"

  # Per-environment Cloud Config
  environment_config = {
    dev = {
      cloud       = "aws"
      aws_account = "111111111111"
    }
    prod = {
      cloud       = "aws"
      aws_account = "222222222222"
    }
  }

}