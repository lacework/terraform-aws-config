terraform {
  required_version = ">= 0.14"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.35.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 2.1"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.7"
    }
    lacework = {
      source  = "lacework/lacework"
      version = "~> 1.0"
    }
  }
}
