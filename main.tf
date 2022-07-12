provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "showcase-1" {
  instance_type = var.ec2-instance
  ami           = "ami-09d56f8956ab235b3"
  tags = {
    yor_trace = "7896"
  }
}

module "server-1" {
  source            = ".//module-1"
  web_instance_type = "t2.micro"
}

module "server-2" {
  source = ".//module-2"
}
