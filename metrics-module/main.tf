resource "aws_efs_file_system" "store" {
  tags = {
    created_for = "cloudfix-linter demo"
    Owner = "ankush.pandey@trilogy.com"
  }

}

module "auth-child1" {
    source            = "..//auth-module//auth-child-module"
    ebs_device_type   = "gp3"
}

module "auth-child2" {
    source            = "..//auth-module//auth-child-module"
    ebs_device_type   = "gp2"
}