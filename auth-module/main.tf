resource "aws_instance" "app-server" {

  ami           = "ami-09d56f8956ab235b3"
  instance_type = var.web_instance_type
  tags = {
    created_for = "cloudfix-linter demo"
    Owner = "ankush.pandey@trilogy.com"
  }
  root_block_device {
    volume_type           = "gp3"
    volume_size           = "8"
    delete_on_termination = true
  }
  ebs_block_device {
    device_name           = "xvda"
    volume_type           = "gp2"
    volume_size           = "8"
    delete_on_termination = true
  }
}

module "auth22" {
  source            = ".//auth-child-module"
  ebs_device_type   = var.ebs_device_type
}