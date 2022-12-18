# resource "aws_ebs_volume" "example" {
#   availability_zone = "us-east-1a"
#   size              = 40

#   tags = {
#     Owner       = "cloudfix-linter"
#   }
# }

# resource "aws_ebs_snapshot" "example_snapshot" {
#   volume_id = aws_ebs_volume.example.id

#   tags = {
#     Owner       = "cloudfix-linter"
#   }
# }

# resource "aws_ami" "cloudfix-linter" {
#   name             = "cloudfix-linter"
#   root_device_name = "/dev/xvda"
#   ebs_block_device {
#     device_name = "/dev/xvda"
#     snapshot_id = aws_ebs_snapshot.example_snapshot.id
#     volume_size = 40
#   }
#   tags = {
#     Owner       = "cloudfix-linter"
#   }
# }