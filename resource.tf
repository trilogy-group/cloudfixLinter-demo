# resource "aws_opensearch_domain" "demo-resource" {
#   domain_name    = "demo-resource"
#   engine_version = "Elasticsearch_7.10"

#   cluster_config {
#     instance_type = "t3.small.search"
#   }

#   ebs_options {
#     ebs_enabled = true
#     volume_size = 10
#   }

#   tags = {
#     Owner     = "cloudfix-linter"
#     Domain      = "Demo-resource"
#   }
# }

# resource "aws_rds_cluster" "cloudfix-linter-demo" {
#   cluster_identifier        = "cloudfix-linter-demo"
#   availability_zones        = ["us-east-1a"]
#   engine                    = "mysql"
#   db_cluster_instance_class = "db.t2.small"
#   storage_type              = "io1"
#   allocated_storage         = 100
#   iops                      = 1000
#   master_username           = "test"
#   master_password           = "somerandompassword"
#   tags = {
#     Owner     = "cloudfix-linter"
#   }
# }

# resource "aws_cloudtrail" "cloudtrail" {
#   name                          = "tf-trail-test"
#   s3_bucket_name                = aws_s3_bucket.b.id
#   s3_key_prefix                 = "prefix"
#   include_global_service_events = false
#   tags = {
#   }
# }

