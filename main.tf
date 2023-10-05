terraform {
  required_version = ">= 0.13.1"

  required_providers {
    shoreline = {
      source  = "shorelinesoftware/shoreline"
      version = ">= 1.11.0"
    }
  }
}

provider "shoreline" {
  retries = 2
  debug = true
}

module "kafka_unauthorized_access_due_to_kafka_acl_misconfiguration" {
  source    = "./modules/kafka_unauthorized_access_due_to_kafka_acl_misconfiguration"

  providers = {
    shoreline = shoreline
  }
}