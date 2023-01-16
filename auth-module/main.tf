resource "aws_instance" "app-server" {

  ami           = "ami-09d56f8956ab235b3"
  instance_type = var.web_instance_type
  subnet_id     = var.subnet_id
  tags = {
    Owner       = "cloudfix-linter@trilogy.com"
  }
}

resource "aws_s3_bucket" "b" {
  bucket_prefix = "my-tf-bucket-cloudfixlinter"
  tags = {
    Owner       = "cloudfix-linter@trilogy.com"
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