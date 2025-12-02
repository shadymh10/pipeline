terraform {
  backend "s3" {
    bucket       = "note-app-pipeline1"
    key          = "eks/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
   
  }
}

