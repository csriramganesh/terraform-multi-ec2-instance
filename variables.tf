variable "instance_type" {
  default = "t3.micro"
  type    = string

}

variable "instance_volume" {
  default = 15
  type    = number

}

variable "aws_ami" {
  default = "ami-01a00762f46d584a1"
  type    = string

}

