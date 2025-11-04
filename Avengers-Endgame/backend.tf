##Endgame backend file to be remotely stored in s3 bucket 

terraform {
  backend "s3" {
    bucket  = "avengerrrsss-endgameee"
    key     = "Avengers-Endgame.tfstate"
    region  = "us-east-1"
    profile = "default"
  }
}


