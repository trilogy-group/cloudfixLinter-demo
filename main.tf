terraform {
  backend "s3" {
    bucket = "my-tf-bucket-cloudfixlinter20230306130022861800000004"
    key    = "tfstate/"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"

}

resource "aws_instance" "app-server" {
  instance_type = var.ec2-instance
  ami           = "ami-09d56f8956ab235b3"
  tags = {
    created_for                 = "cloudfix-linter demo"
    Owner                       = "ankush.pandey@trilogy.com"
    yor_trace                   = "a25cea7e-6674-437a-ae4e-05c0b2d99c79"
    "cloudfix:linter_yor_trace" = "bd867443-76bb-4f0a-b6b3-4473a00d29f2"
  }
}

resource "aws_ebs_volume" "data-vol" {
  availability_zone = "us-east-1a"
  size              = 1
  type              = "gp2"
  tags = {
    created_for                 = "cloudfix-linter demo"
    Owner                       = "ankush.pandey@trilogy.com"
    yor_trace                   = "71d9e6ef-a390-4959-8aef-46d8e4df1b9d"
    "cloudfix:linter_yor_trace" = "634512e0-5a2a-4e8d-918f-92e479fcab19"
  }
}

resource "aws_ebs_volume" "config-vol" {
  availability_zone = "us-east-1a"
  size              = 1
  #type              = "gp2"
  tags = {
    created_for                 = "cloudfix-linter demo"
    Owner                       = "ankush.pandey@trilogy.com"
    yor_trace                   = "9d739d1b-83d8-46a5-b465-05560523a82a"
    "cloudfix:linter_yor_trace" = "4d90f3fd-2b04-48d5-8202-01c769579fd8"
  }
}

module "auth" {
  source            = ".//auth-module"
  web_instance_type = "t2.micro"
}

module "metrics" {
  source = ".//metrics-module"
}
