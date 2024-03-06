terraform {
  required_providers {
    null = {
      source = "hashicorp/null"
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.38"
    }
    time = {
      source  = "hashicorp/time"
      version = ">= 0.7.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = ">= 3.0"
    }
    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = ">= 2.0"
    }
  }
  required_version = ">= 1.3"
}
