provider "aws" {
  region = "us-east-1"

}

resource "aws_instance" "showcase-1" {
  instance_type = var.ec2-instance
  ami           = "ami-09d56f8956ab235b3"

}

resource "aws_ebs_volume" "example" {
  availability_zone = "us-east-1a"
  size              = 1
  type              = "gp2"
  
}

resource "aws_ebs_volume" "example2" {
  availability_zone = "us-east-1a"
  size              = 1
  #type              = "gp2"
 
}

module "server-1" {
  source            = ".//module-1"
  web_instance_type = "t2.micro"
}

module "server-2" {
  source = ".//module-2"
}