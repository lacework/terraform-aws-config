terraform {
  required_version = ">= 0.14"

  required_providers {
    aws    = ">= 3.35.0, < 6.0.0"
    random = ">= 2.1"
    time   = "~> 0.6"
    lacework = {
      source  = "lacework/lacework"
      version = "~> 1.0"
    }
  }
}
