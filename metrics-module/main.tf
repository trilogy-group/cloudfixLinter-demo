resource "aws_efs_file_system" "store" {
  tags = {
    Owner     = "cloudfix-linter@trilogy.com"
    yor_trace = "36644629-e01e-4758-af16-0f33be7250a4"
  }

}
