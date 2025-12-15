terraform {
  required_version = ">= 1.0.0"


  backend "s3" {
    bucket = "my-terraform-state-ihb"
    key    = "prod"
    region = "eu-central-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }

    http = {
      source  = "hashicorp/http"
      version = "~> 3.5.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.1.0"
    }
  }
}

