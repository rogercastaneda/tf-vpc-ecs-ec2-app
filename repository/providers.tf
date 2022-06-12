provider "aws" {
  region  = "us-east-1"
  profile = "my-profile"
  alias   = "my-profile"
}

provider "aws" {
  region  = "us-east-1"
  profile = "my-profile"
}
