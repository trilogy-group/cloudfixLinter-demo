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

resource "aws_ebs_volume" "example" {
  availability_zone = "us-east-1a"
  size              = 1
  type              = "gp2"
  tags = {
    yor_trace = "9001"
  }
}
