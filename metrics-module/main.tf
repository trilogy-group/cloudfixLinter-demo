resource "aws_efs_file_system" "store" {
  tags = {
    Owner     = "ankush.pandey@trilogy.com"
  }

}
