resource "aws_key_pair" "my_key" {
  key_name   = "terra-ki-key"
  public_key = file("terra-ki-key.pub")

}

resource "aws_default_vpc" "default" {

}

resource "aws_security_group" "my_group" {
  name   = "automate-sg1"
  vpc_id = aws_default_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {
    Name = "automate-sg1"
  }


}

resource "aws_instance" "my_instance" {
  #count           = 3 # use meta argument count to create multiple resources
  # when you use count = 3 all the instance names will be same to have diff names for diff instances 
  # you need to use another meta argument for_each
  for_each = ({
    sriram-123 = "t3.micro"
    sriram-456 = "t3.micro"
  })
  # another mete argument is depends_on
  depends_on      = [aws_security_group.my_group] # after security group created instance need to get created
  key_name        = aws_key_pair.my_key.key_name
  security_groups = [aws_security_group.my_group.name]
  #instance_type   = var.instance_type  ->this when you use variable 
  instance_type = each.value # this when you use for_each if you want name then each.key key-value pair
  ami           = var.aws_ami
  user_data     = file("install-nginx.sh")

  # root_block_device {
  #   volume_type = "gp3"
  #  volume_size = var.ece_default_instance_volume # This whole root_block_device for normal creation 
  # }
  # conditional expression in terraform like if else if environment is prd or dev then 
  # volume size needs to be 20 else 10 how to this
  root_block_device {
    volume_type = "gp3" #  env is prod ? (? is if) true : false 20 : var.ec2 
    volume_size = var.environment == "prd" ? 20 : var.ec2_default_instance_volume
  }

  tags = {
    Name = each.key # once for sriram-123 another time it takes sriram-456 key-value pair
  }


}


