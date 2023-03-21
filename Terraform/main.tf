provider "aws" {
  region = "us-east-1"

}

resource "aws_instance" "app-server" {
  instance_type = var.ec2-instance
  ami           = var.ami
  subnet_id     = var.subnet_id
  tags = {
    Owner     = "ankush.pandey@trilogy.com"
  }
}

resource "aws_ebs_volume" "data-vol" {
  availability_zone = "us-east-1a"
  size              = 1
  type              = "gp2"
  tags = {
    Owner     = "ankush.pandey@trilogy.com"
  }
}

resource "aws_ebs_volume" "config-vol" {
  availability_zone = "us-east-1a"
  size              = 1
  #type              = "gp2"
  tags = {
    Owner     = "ankush.pandey@trilogy.com"
  }
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id       = var.vpc_id
  service_name = "com.amazonaws.us-east-1.s3"
  tags = {
    Owner     = "ankush.pandey@trilogy.com"
  }
}

resource "aws_nat_gateway" "example" {
  connectivity_type = "private"
  subnet_id         = var.subnet_id
  tags = {
    Owner     = "ankush.pandey@trilogy.com"
  }
}

resource "aws_neptune_cluster" "default" {
  cluster_identifier                   = "neptune-cluster-development"
  engine                               = "neptune"
  engine_version                       = "1.2.0.1"
  neptune_cluster_parameter_group_name = "default.neptune1.2"
  skip_final_snapshot                  = true
  apply_immediately                    = true
  tags = {
    Owner     = "ankush.pandey@trilogy.com"
  }
}

resource "aws_dynamodb_table" "cloudfix-linter" {
  name         = "cloudfixlinter"
  hash_key     = "TestTableHashKey"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "TestTableHashKey"
    type = "S"
  }
  tags = {
    Owner     = "ankush.pandey@trilogy.com"
  }
}

module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  count = 1

  name = "single-instance"

  ami           = var.ami
  instance_type = "t2.micro"
  monitoring    = true
  subnet_id     = var.subnet_id

  tags = {
    Owner     = "ankush.pandey@trilogy.com"
  }
}

module "s3_bucket_remote" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "my-remote-s3-bucket"
  acl    = "private"

  versioning = {
    enabled = true
  }

  tags = {
    Owner     = "ankush.pandey@trilogy.com"
  }
}

module "remote_module_from_s3" {
  source = "s3::https://s3.amazonaws.com/remote-module-cflint-prasheel/remote-module.zip"
  tags = {
    Owner     = "ankush.pandey@trilogy.com"
  }
}

module "auth" {
  source = ".//auth-module"
}

module "metrics" {
  source = ".//metrics-module"
}