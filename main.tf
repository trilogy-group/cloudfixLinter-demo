provider "aws" {
  region = "us-east-1"

}

resource "aws_instance" "app-server" {
  instance_type = var.ec2-instance
  ami           = var.ami
  subnet_id     = var.subnet_id
  tags = {
    Owner     = "cloudfix-linter@trilogy.com"
    yor_trace = "ad8d7c23-d5d4-4828-a5d4-479d7a794f1b"
  }
}

resource "aws_ebs_volume" "data-vol" {
  availability_zone = "us-east-1a"
  size              = 1
  type              = "gp2"
  tags = {
    Owner     = "cloudfix-linter@trilogy.com"
    yor_trace = "357ac2aa-7192-4616-a99c-bc1b6265b18c"
  }
}

resource "aws_ebs_volume" "config-vol" {
  availability_zone = "us-east-1a"
  size              = 1
  #type              = "gp2"
  tags = {
    Owner     = "cloudfix-linter@trilogy.com"
    yor_trace = "887167db-0cea-4cd4-b5ef-ca4479bb9a5b"
  }
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id       = var.vpc_id
  service_name = "com.amazonaws.us-east-1.s3"
  tags = {
    Owner     = "cloudfix-linter@trilogy.com"
    yor_trace = "ca266a2e-6ddb-41e7-b3a7-8c3b8e685976"
  }
}

resource "aws_nat_gateway" "example" {
  connectivity_type = "private"
  subnet_id         = var.subnet_id
  tags = {
    Owner     = "cloudfix-linter@trilogy.com"
    yor_trace = "8b3b0a35-ac1c-4f5d-b3f6-27658d168007"
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
    Owner     = "cloudfix-linter@trilogy.com"
    yor_trace = "19eb87ce-a9a3-4e08-9360-972985923a08"
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
    Owner     = "cloudfix-linter@trilogy.com"
    yor_trace = "39fbd6e0-2348-4b7f-a411-5a8c2fbc3aae"
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
    Owner     = "cloudfix-linter@trilogy.com"
    yor_trace = "9e6417a5-9785-4e06-b151-495265993f63"
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
    Owner     = "cloudfix-linter@trilogy.com"
    yor_trace = "91ff2b14-6ed5-4de2-8a9b-cefc8ab8117e"
  }
}

module "remote_module_from_s3" {
  source = "s3::https://s3.amazonaws.com/remote-module-cflint-prasheel/remote-module.zip"
  tags = {
    Owner     = "cloudfix-linter@trilogy.com"
    yor_trace = "53c95f47-385c-4447-afeb-f241c6d4e163"
  }
}

module "auth" {
  source = ".//auth-module"
}

module "metrics" {
  source = ".//metrics-module"
}