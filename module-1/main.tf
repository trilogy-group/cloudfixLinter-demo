resource "aws_instance" "showcase-1" {

  ami           = "ami-09d56f8956ab235b3"
  instance_type = var.web_instance_type
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
