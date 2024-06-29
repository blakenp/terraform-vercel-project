variable "repo_name" {
  type = string
  description = "Name of git repo storing code."
}

variable "app_name" {
  type        = string
  description = "Application name to name your Vercel Project. Must be <= 28 characters."
  validation {
    condition     = length(var.app_name) <= 28
    error_message = "Must be <= 28 characters."
  }
}

variable "env" {
  type        = string
  description = "Environment whether prd or stg for deployment of app."
  default     = "stg"
}

variable "branch" {
  type        = string
  description = "The branch name for the deployment"
}

variable "environment_variables" {
  type        = map(string)
  description = "A map that defines environment variables for the vercel project."
  default     = {}
}

variable "domain_url" {
  type        = string
  description = "Custom domain URL for the application."
  default     = null
}

variable "hosted_zone" {
  type = object({
    name = string,
    id   = string
  })
  description = "Hosted Zone object to redirect to app's running code. A and AAAA records created in this hosted zone."
}

variable "role_permissions_boundary_arn" {
  type        = string
  description = "IAM Role Permissions Boundary ARN."
  default     = null
}

variable "vercel_team" {
  type        = string
  description = "Team id for organizing vercel projects in teams."
}

variable "vercel_api_token" {
  type        = string
  description = "Vercel api token used to create and manage vercel resources through terraform apis."
}

variable "vercel_project_framework" {
  type        = string
  description = "Framework that vercel project's code is written in."
  default     = "nextjs"
}

variable "vercel_production_branch" {
  type        = string
  description = "Production branch for vercel project for future project deployments."
}

variable "install_command" {
  type        = string
  description = "Install command run by vercel for all deployments."
  default     = null
}

variable "build_command" {
  type        = string
  description = "Build command for building projects to deploy on Vercel."
  default     = null
}

variable "output_directory" {
  type        = string
  description = "Output directory for statically built app."
  default     = null
}

variable "dev_command" {
  type        = string
  description = "Command for dev environment builds for vercel deployments."
  default     = null
}

variable "root_directory" {
  type        = string
  description = "The root directory that holds the package.json and other dependencies."
  default     = null
}
