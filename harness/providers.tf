terraform {
  required_providers {
    harness = {
      source  = "harness/harness"
      version = "0.35.1"
    }
  }
  required_version = ">= 1.9"
}

provider "harness" {
  endpoint         = "https://app.harness.io/gateway"
  account_id       = "kMVvuPEhRLKsoxjW4VFj0w"
  platform_api_key = "pat.kMVvuPEhRLKsoxjW4VFj0w.67994712996fdd6ca78a6240.sbQtHyi1NV6kDLRrbXVi"
}
