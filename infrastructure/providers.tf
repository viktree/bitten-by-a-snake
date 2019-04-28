# Configure the AWS Provider
provider "aws" {
  version = "~> 2.7"
  region  = "us-east-1"
}

provider "archive" {
  version = "~> 1.2"
}