resource "aws_instance" "app-server" {

  ami           = var.ami
  instance_type = var.web_instance_type
  subnet_id     = var.subnet_id
  tags = {
    Owner     = "cloudfix-linter@trilogy.com"
    yor_trace = "3fb1627a-a429-42b0-81f8-a8e0695a4d18"
  }
}

resource "aws_s3_bucket" "b" {
  bucket_prefix = "my-tf-bucket-cloudfixlinter"
  tags = {
    Owner     = "cloudfix-linter@trilogy.com"
    yor_trace = "5b6569e4-ee9d-4965-a50c-eed495b96705"
  }

}

# resource "aws_cloudtrail" "cloudtrail" {
#   name                          = "tf-trail-test"
#   s3_bucket_name                = aws_s3_bucket.b.id
#   s3_key_prefix                 = "prefix"
#   include_global_service_events = false
#   tags = {
#     Owner       = "cloudfix-linte
#   }
# }