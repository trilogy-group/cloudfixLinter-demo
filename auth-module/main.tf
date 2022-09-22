resource "aws_instance" "app-server" {

  ami           = "ami-09d56f8956ab235b3"
  instance_type = var.web_instance_type
  subnet_id     = "subnet-0103f016fd921604d"
  tags = {
    created_for = "cloudfix-linter demo"
  }
}

resource "aws_s3_bucket" "b" {
  bucket_prefix = "my-tf-bucket-cloudfixlinter"
  tags = {
    created_for = "cloudfix-linter demo"
  }

}
