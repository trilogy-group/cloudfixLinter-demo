resource "aws_instance" "app-server" {                      // zz problem, fix this by enabling kk for a resource with a module path: root->child->grandchild...   

  ami           = "ami-09d56f8956ab235b3"
  instance_type = var.web_instance_type                     // change this to xx to save yy dollars for a resource with a module path: root->child->grandchild...   
  tags = {
    created_for = "cloudfix-linter demo"
    Owner = "ankush.pandey@trilogy.com"
  }
  root_block_device {                                         // zz...
    volume_type           = "gp3"                             // change...
    volume_size           = "8"
    delete_on_termination = true
  }
  ebs_block_device {                                          // zz...
    device_name           = "xvda"
    volume_type           = "gp2"                             // change...
    volume_size           = "8"
    delete_on_termination = true
  }
}

resource "aws_instance" "app-server2" {                       // zz...

  ami           = "ami-09d56f8956ab235b3"
  instance_type = "t2.micro"                                  // change...
  tags = {
    created_for = "cloudfix-linter demo"
    Owner = "ankush.pandey@trilogy.com"
  }
}

module "auth-child1" {
  source            = ".//auth-child-module"
  ebs_device_type   = var.ebs_device_type                      // change...
}