resource "aws_instance" "app-server" {

  ami           = "ami-09d56f8956ab235b3"
  instance_type = var.web_instance_type
  tags = {
    created_for                 = "cloudfix-linter demo"
    Owner                       = "ankush.pandey@trilogy.com"
    yor_trace                   = "3db4d690-47e6-489e-a55b-1cade404081e"
    "cloudfix:linter_yor_trace" = "a47c932e-dc89-4463-a29d-eb37c64b835c"
  }
}

resource "aws_s3_bucket" "b" {
  bucket_prefix = "my-tf-bucket-cloudfixlinter"
  tags = {
    created_for                 = "cloudfix-linter demo"
    Owner                       = "ankush.pandey@trilogy.com"
    yor_trace                   = "9a9b5698-77ce-4ed6-8269-aec1a963abe9"
    "cloudfix:linter_yor_trace" = "e697455d-16d8-4354-81e3-74a7058c41af"
  }

}
