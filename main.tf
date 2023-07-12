  provider "aws" {
  region = "us-east-1"

}

resource "aws_instance" "app-server" {          //zz problem, fix this by enabling kk for a resource with a module path: root             || for Non-attribute problems
  instance_type = var.ec2-instance              //Change this to xx to save yy dollars annually for a resource with a module path: root      ||note: this var in root implies default value
  ami           = "ami-09d56f8956ab235b3"
  tags = {
    created_for = "cloudfix-linter demo"
    Owner = "ankush.pandey@trilogy.com"
  }
    root_block_device {                          //zz problem, fix this by enabling kk for a resource with a module path: root  
    volume_type           = "gp2"                //Change this to xx to save yy dollars annually for a resource with a module path: root
    volume_size           = "8"
    delete_on_termination = true
  }
  ebs_block_device {                              //......
    device_name           = "xvda"                
    volume_type           = "gp3"                 //.......
    volume_size           = "8"
    delete_on_termination = true
  }
      ebs_block_device {                          //.......
    device_name           = "xvdb"                
    volume_type           = "gp3"                 //.......
    volume_size           = "8"
    delete_on_termination = true
  }

}

resource "aws_ebs_volume" "data-vol" {             //.......
  availability_zone = "us-east-1a"
  size              = 1
  type              = "gp2"                        //.......
  tags = {
    created_for = "cloudfix-linter demo"
    Owner = "ankush.pandey@trilogy.com"
  }
}

resource "aws_ebs_volume" "config-vol" {          //.......
  availability_zone = "us-east-1a"
  size              = 1
  #type              = "gp2"                       //......
  tags = {
    created_for = "cloudfix-linter demo"
    Owner = "ankush.pandey@trilogy.com"
  }
}

module "auth" {                                 || Note: for modules blocks there are no global problems, only variable('var') problems are trasferred
  source            = ".//auth-module"
  web_instance_type = "t2.micro"                // Change this to xx to save yy dollars for a resource with a module path: root->child->grandchild...   
  ebs_device_type   = "gp2"                     //......       ||Note: giving the entire module path, allows tf developers to position their variables in a suitable place. Its difficult to predict that suitable place for all cases which depends upon the level where module duplication is done, hence the enitre path to guide developers. Why this works? coz all module paths uniquely lead to a single module instance/ duplicate module paths from root, can't exist
}

module "auth2" {
  source            = ".//auth-module"
  web_instance_type = "t3a.micro"               //......
  ebs_device_type   = "gp2"                     //......
}

module "metrics" {
  source = ".//metrics-module"
}

module "remote-test" {
    source            = "git::https://github.com/yashg-ti/Test.git"
    web_instance_type = "t2.micro"              //......
}
