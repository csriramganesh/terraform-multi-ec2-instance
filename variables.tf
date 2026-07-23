variable "instance_type" {
  default = "t3.micro"
  type    = string

}

variable "ec2_default_instance_volume" {
  default = 10
  type    = number

}

variable "aws_ami" {
  default = "ami-01a00762f46d584a1"
  type    = string

}

variable "environment" {
  default = "prd"
  type    = string

}
