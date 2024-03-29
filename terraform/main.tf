terraform {
  required_providers {
    scaleway = {
      source = "scaleway/scaleway"
    }
  }
  required_version = ">= 0.13"
}

provider "scaleway" {
  zone   = "fr-par-1"
  region = "fr-par"
  project_id = "8812b4f4-fe78-4933-9a36-80b86dd2f5e1"
}