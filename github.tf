terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }
}

# Configure the GitHub Provider
provider "github" {
    token = "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"
}
resource "github_repository" "kamran" {
  name        = "terraformrepo"
  description = "My awesome codebase"

  visibility = "public"
}
