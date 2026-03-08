terraform {
  backend "s3" {
    encrypt                     = true
    insecure                    = false
    skip_credentials_validation = false
    use_fips_endpoint           = true
    use_lockfile                = true
  }
}
