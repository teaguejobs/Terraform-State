terraform {
  cloud {
    organization = "<ORG_NAME>"

    workspaces {
      name = "labs-migrate-state"
    }
  }
}