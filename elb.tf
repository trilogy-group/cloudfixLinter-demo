# resource "aws_elb" "cloudfix-linter" {
#   name               = "cloudfix-linter-terraform-elb"
#   availability_zones = ["us-east-1a"]

#   access_logs {
#     bucket        = "linter"
#     bucket_prefix = "cloudfix-"
#     interval      = 60
#   }

#   listener {
#     instance_port     = 8000
#     instance_protocol = "http"
#     lb_port           = 80
#     lb_protocol       = "http"
#   }

#   listener {
#     instance_port      = 8000
#     instance_protocol  = "http"
#     lb_port            = 443
#     lb_protocol        = "https"
#     ssl_certificate_id = "arn:aws:iam::123456789012:server-certificate/certName"
#   }

#   health_check {
#     healthy_threshold   = 2
#     unhealthy_threshold = 2
#     timeout             = 3
#     target              = "HTTP:8000/"
#     interval            = 30
#   }

#   instances                   = [aws_instance.app-server.id]
#   cross_zone_load_balancing   = true
#   idle_timeout                = 400
#   connection_draining         = true
#   connection_draining_timeout = 400

#   tags = {
#     Name        = "cloudfix-linter-terraform-elb"
#     Owner     = "cloudfix-linter"
#   }
# }