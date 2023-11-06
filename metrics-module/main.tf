resource "aws_efs_file_system" "store" {                // zz problem, fix this by enabling kk for a resource with a module path: root->child->grandchild...               || for Non-attribute problems
  tags = {
    created_for = "cloudfix-linter demo"
    Owner = "ankush.pandey@trilogy.com"
  }

}

module "auth-child1" {
    source            = "..//auth-module//auth-child-module"          // ||Note: why whis(sourcing super directories) was never a problem check work flowy
    ebs_device_type   = "gp3"                         // Change this to yy to save xx dollars for a resource with a module path : root->child->grandchild...
}

module "auth-child2" {
    source            = "..//auth-module//auth-child-module"
    ebs_device_type   = "gp2"                         // .....
}