resource "aws_instance" "app-server" {

  ami           = "ami-09d56f8956ab235b3"
  instance_type = var.web_instance_type
  tags = {
    created_for = "cloudfix-linter demo"
    Owner = "ankush.pandey@trilogy.com"
  }
  root_block_device {
    volume_type           = "gp2"
    volume_size           = "8"
    delete_on_termination = true
  }
  ebs_block_device {
    device_name           = "xvda"
    volume_type           = "gp2"
    volume_size           = "8"
    delete_on_termination = true
  }
}

resource "aws_s3_bucket" "b" {
  bucket_prefix = "my-tf-bucket-cloudfixlinter"
  tags = {
    created_for = "cloudfix-linter demo"
    Owner = "ankush.pandey@trilogy.com"
  }

}
