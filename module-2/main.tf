resource "aws_efs_file_system" "foo" {
  tags = {    
    created_for = "cloudfix-linter demo"
  }
  
}
