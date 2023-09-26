# Provider that access Lacework sub-account named "account-1"
provider "lacework" {
  subaccount = "account-1"
  alias      = "account-1"
}

# Provider that access Lacework sub-account named "account-2"
provider "lacework" {
  subaccount = "account-2"
  alias      = "account-2"
}

# Provider that access Lacework sub-account named "account-3"
provider "lacework" {
  subaccount = "account-3"
  alias      = "account-3"
}

# Provider that access AWS account "1234567890101"
provider "aws" {
  profile = "1234567890101"
  alias   = "account-1"
}

# Provider that access AWS account "1234567890102"
provider "aws" {
  profile = "1234567890102"
  alias   = "account-2"
}

# Provider that access AWS account "1234567890103"
provider "aws" {
  profile = "1234567890103"
  alias   = "account-3"
}
