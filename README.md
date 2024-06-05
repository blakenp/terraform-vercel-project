# terraform-vercel-project
Example use of module:

```
module "vercel_project" {
  # Required Variable
  src = "github.com/blakenp/terraform-vercel-project"

  # Basic Project Information
  app_name  = var.app_name # Optional (Description: Application name)
  env       = var.env      # Optional (Description: Deployment environment)
  branch    = var.branch    # Optional (Description: Branch for deployment)

  # Environment Variables (Optional)
  environment_variables = var.environment_variables # Optional (Description: Map of environment variables)

  # Custom Domain (Optional)
  domain_url  = var.domain_url  # Optional (Description: Custom domain URL)
  hosted_zone = var.hosted_zone # Optional (Description: Hosted Zone object for domain redirection)

  # IAM Role and Vercel Configuration (Optional)
  role_permissions_boundary_arn = var.role_permissions_boundary_arn # Optional (Description: IAM Role Permissions Boundary ARN)
  vercel_team                   = var.vercel_team                   # Optional (Description: Vercel team ID for project organization)
  vercel_api_token               = var.vercel_api_token               # Optional (Description: Vercel API token for Terraform operations)

  # Build Configuration (Optional)
  vercel_project_framework = var.vercel_project_framework # Optional (Description: Project's code framework - default: nextjs)
  vercel_production_branch  = var.vercel_production_branch  # Optional (Description: Production branch for future deployments)
  install_command            = var.install_command            # Optional (Description: Install command run by Vercel)
  build_command              = var.build_command              # Optional (Description: Build command for deployments)
  output_directory          = var.output_directory          # Optional (Description: Output directory for statically built app)
  dev_command                = var.dev_command                # Optional (Description: Dev environment build command)
  root_directory              = var.root_directory              # Optional (Description: Directory containing package.json)
}

```