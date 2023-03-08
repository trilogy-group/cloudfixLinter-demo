resource "aws_efs_file_system" "store" {
  tags = {
    created_for                 = "cloudfix-linter demo"
    Owner                       = "ankush.pandey@trilogy.com"
    yor_trace                   = "6df024ae-af48-4cc3-a6b0-880e8bc80dbb"
    "cloudfix:linter_yor_trace" = "df77d4dd-ad56-42a1-8f6e-1ff441efa0ec"
  }

}
