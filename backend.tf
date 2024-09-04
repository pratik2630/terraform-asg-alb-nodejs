terraform {
  backend "s3" {
    bucket         = "my-terraform-project-aug-2024"
    key            = "./terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-state-locks"
    encrypt        = true
  }
}





