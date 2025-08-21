terraform {
  backend "s3" {
    bucket = "terraform-bucket-devsec-multicloud"
    key    = "backend"
    region = "us-east-1"
  }
}
