resource "aws_efs_file_system" "store" {
  tags = {
    created_for = "cloudfix-linter demo"
    Owner = "ankush.pandey@trilogy.com"
  }

}
