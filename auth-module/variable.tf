variable "web_instance_type" {
  type = string
  default = "t2.micro"
}

variable "subnet_id" {
  type = string
  default = "subnet-0103f016fd921604d"
}

variable "ami"  {
  type =string
  default = "ami-09d56f8956ab235b3"
}
