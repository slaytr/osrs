terraform {
  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "ap-southeast-2"

  // remove for prod
  endpoints {
    iam      = "http://localhost:4566"
    lambda   = "http://localhost:4566"
    dynamodb = "http://localhost:4566"
    s3       = "http://s3.localhost.localstack.cloud:4566"
  }
}
