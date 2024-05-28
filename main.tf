terraform {
  required_version = ">= 1.8.4"
  required_providers {
    aws = ">= 5.51.1"
    vercel = {
      source  = "vercel/vercel"
      version = "~> 1.11.0"
    }
  }
}

# ==================== Locals ====================

locals {
  project_name   = var.app_name
  app_domain_url = var.domain_url != null ? var.domain_url : "${var.app_name}.${var.hosted_zone.name}" // Route53 A record name

  records = var.records
}

# ==================== Route53 ====================

resource "aws_route53_record" "a_record" {
  name    = local.app_domain_url
  type    = "A"
  zone_id = var.hosted_zone.id
  ttl     = 300
  records = local.records
}

# currently vercel doesn't support redirecting apps to aaaa records, but in the future when they
# support this, this block can be uncommented
# resource "aws_route53_record" "aaaa_record" {
#     name    = local.app_domain_url
#     type    = "AAAA"
#     zone_id = var.hosted_zone.id
#     ttl     = 300
#     records = local.records
# }

# ==================== Vercel Project and Deployments ====================

provider "vercel" {
  api_token = var.vercel_api_token
  team      = var.vercel_team // You can find our team id under the settings tab of the teams account associated with the fhtlab gmail
}

resource "vercel_project" "config" {
  name      = local.project_name // This is how the name of your project will appear on Vercel
  framework = var.vercel_project_framework
  git_repository = {
    type              = "github"
    repo              = "blakenp/${local.project_name}" // Make sure to always enter the lab organization name 'byuawsfhtl' and your app/repo name
    production_branch = var.vercel_production_branch    // Define production branch here. It is usually master or main
  }

  install_command  = var.install_command // You can configure all commands used for deployments as default commands here and they will apply to every app deployment, regardless of branch
  build_command    = var.build_command
  output_directory = var.output_directory
  dev_command      = var.dev_command
  root_directory   = var.root_directory // Replace this with wherever those config files are (the directory string can't start with leading slashes i.e. '/')
}

data "vercel_project_directory" "root" {
  path = "../../../../${local.project_name}" // This is just the root of your project
}

resource "vercel_deployment" "config" {
  project_id  = vercel_project.config.id
  ref         = var.branch
  path_prefix = "../../../../${local.project_name}"
  production  = (var.env == "prd") ? true : false // will only be a production deployment on the master/main branch

  project_settings = {                    // Note that project settings in vercel_deployment block only apply to current deployment activated by github actions, these are not default to all app deployments. 
    install_command = var.install_command // configure install commands here
    build_command   = var.build_command   // configure build commands here
  }
}

resource "vercel_project_domain" "config" {
  project_id = vercel_project.config.id
  domain     = local.app_domain_url                // Configure the domain name you want for your app here
  git_branch = (var.env == "prd") ? null : var.env // git branch that will be associated with specific branch in deployment
}

resource "vercel_project_environment_variable" "config" {
  for_each = var.environment_variables

  project_id = vercel_project.config.id
  key        = each.key
  value      = each.value
  target     = (var.env == "prd") ? ["production"] : ["preview", "development"]
}
