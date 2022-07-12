resource "aws_instance" "showcase-1" {

  ami           = "ami-09d56f8956ab235b3"
  instance_type = var.web_instance_type
  tags = {
    yor_trace = "1802"
  }
}
