provider "aws" {
  region = "us-east-1"

}

resource "aws_instance" "app-server" {
  instance_type = var.ec2-instance
  ami           = "ami-09d56f8956ab235b3"
  subnet_id     = "subnet-0103f016fd921604d"
  tags = {
    created_for = "cloudfix-linter demo"
  }
}

resource "aws_ebs_volume" "data-vol" {
  availability_zone = "us-east-1a"
  size              = 1
  type              = "gp2"
  tags = {
    created_for = "cloudfix-linter demo"
  }
}

resource "aws_ebs_volume" "config-vol" {
  availability_zone = "us-east-1a"
  size              = 1
  #type              = "gp2"
  tags = {
    created_for = "cloudfix-linter demo"
  }
}

module "auth" {
  source            = ".//auth-module"
  web_instance_type = "t2.micro"
}

module "metrics" {
  source = ".//metrics-module"
}
