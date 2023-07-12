variable "ebs_device_type" {
  type = string
}


resource "aws_ebs_volume" "data-vol" {
  availability_zone = "us-east-1a"
  size              = 1
  type              = var.ebs_device_type         // change this to xx to save yy dollars for a resource with a module path: root->child->grandchild...   
  tags = {
    created_for = "cloudfix-linter demo"
    Owner = "ankush.pandey@trilogy.com"
  }
}