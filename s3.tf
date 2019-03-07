terraform {
  backend "s3" {
    bucket   = "cloud_media"
    key      = "terraform.tfstate"
    region   = "eu-west-2"
    endpoint = "https://osu.eu-west-2.outscale.com"
    skip_credentials_validation = true
  }
}
