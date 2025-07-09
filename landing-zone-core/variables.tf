

# variable "github_configs" {
#     description = "Map of GitHub repository configurations"
#     type = map(object({
#         github_environments = list(string)
#         visibility          = string
#         collaborators       = list(object({
#             team_id    = string
#             permission = string
#         }))
#     }))
#     default = {}

# }

variable "tfe_organization" {
  description = "Terraform Cloud organization name"
  type        = string
  default     = "Lennar" # Replace with your Terraform Cloud org
}

variable "github_organization" {
  description = "GitHub organization name"
  type        = string
  default     = "migration-test-len-01" # Replace with your GitHub organization

}

variable "TF_API_TOKEN" {
  description = "Terraform"
  type        = string
  default     = ""

}

# variable "project_name" {
#   description = "Name of the project"
#   type        = string
# }





variable "app_acronym" {
  type = string
}

variable "app_name" {
  type = string
}

variable "app_description" {
  type = string
}

variable "gh_org" {
  type = string
}

variable "gh_team" {
  type = string
}

variable "gh_permission" {
  type = string
}

variable "repo_suffix" {
  type = string
}

variable "template_organization" {
  type = string
}

variable "template_repository" {
  type = string
}

variable "environment_config" {
  type = map(object({
    cloud           = string
    aws_account     = optional(string)
    subscription_id = optional(string)
  }))

  validation {
    condition = alltrue([
      for cfg in var.environment_config : (
        (cfg.cloud != "aws" || (try(length(cfg.aws_account), 0) > 0)) &&
        (cfg.cloud != "azure" || (try(length(cfg.subscription_id), 0) > 0))
      )
    ])
    error_message = "If 'cloud' is 'aws', 'aws_account' must be set. If 'cloud' is 'azure', 'subscription_id' must be set."
  }
}

 