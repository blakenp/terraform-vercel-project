output "vercel_project_id" {
  value = vercel_project.config.id
}

output "vercel_project_url" {
  value = vercel_project_domain.config.domain
}

output "vercel_deployment_id" {
  value = vercel_deployment.config.id
}
