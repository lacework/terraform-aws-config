terraform {
  required_version = ">= 0.12.31"

  required_providers {
    aws    = ">= 3.35.0, < 5.0.0"
    random = ">= 2.1"
    time   = "~> 0.6"
    lacework = {
      source  = "lacework/lacework"
      version = "~> 0.2"
    }
  }
}
