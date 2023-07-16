provider "aws" {
  region = "us-east-1"

}

resource "aws_instance" "app-server" {
  instance_type = var.ec2-instance
  ami           = "ami-09d56f8956ab235b3"
  tags = {
    created_for = "cloudfix-linter demo"
    Owner = "ankush.pandey@trilogy.com"
  }
    root_block_device {
    volume_type           = "gp2"
    volume_size           = "8"
    delete_on_termination = true
  }
  ebs_block_device {
    device_name           = "xvda"
    volume_type           = "gp3"
    volume_size           = "8"
    delete_on_termination = true
  }
      ebs_block_device {
    device_name           = "xvdb"
    volume_type           = "gp3"
    volume_size           = "8"
    delete_on_termination = true
  }

}

resource "aws_ebs_volume" "data-vol" {
  availability_zone = "us-east-1a"
  size              = 1
  type              = "gp2"
  tags = {
    created_for = "cloudfix-linter demo"
    Owner = "ankush.pandey@trilogy.com"
  }
}

resource "aws_ebs_volume" "config-vol" {
  availability_zone = "us-east-1a"
  size              = 1
  #type              = "gp2"
  tags = {
    created_for = "cloudfix-linter demo"
    Owner = "ankush.pandey@trilogy.com"
  }
}

module "auth" {
  source            = ".//auth-module"
  web_instance_type = "t2.micro"
  ebs_device_type   = "gp2"
}

module "auth2" {
  source            = ".//auth-module"
  web_instance_type = "t3a.micro"
  ebs_device_type   = "gp2"
}

module "metrics" {
  source = ".//metrics-module"
}

module "remote-test" {
    source            = "github.com/trilogy-group/Terraform-test-module" 
    web_instance_type = "t2.micro"
}
