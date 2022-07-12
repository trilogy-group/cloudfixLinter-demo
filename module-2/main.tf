resource "aws_ebs_volume" "example" {
  availability_zone = "us-east-1a"
  size              = 1
  type              = "gp2"
  tags = {
    yor_trace = "9089"
  }
}
