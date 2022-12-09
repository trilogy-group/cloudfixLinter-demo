resource "aws_instance" "app-server" {

  ami           = "ami-09d56f8956ab235b3"
  instance_type = var.web_instance_type
  subnet_id     = "subnet-0ad82a9a46e5aaf68"
  tags = {
    owner       = "prasheel.tiwari@trilogy.com"
    created_for = "cloudfix-linter demo"
  }
}

resource "aws_s3_bucket" "b" {
  bucket_prefix = "my-tf-bucket-cloudfixlinter"
  tags = {
    created_for = "cloudfix-linter demo"
  }

}

# resource "aws_cloudtrail" "cloudtrail" {
#   name                          = "tf-trail-test"
#   s3_bucket_name                = aws_s3_bucket.b.id
#   s3_key_prefix                 = "prefix"
#   include_global_service_events = false
#   tags = {
#     created_for = "cloudfix-linter demo"
#     yor_trace = "385b58f7-8bbc-47e9-af0f-998d00a5850c"
#   }
# }