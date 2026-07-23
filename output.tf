# this is for single instance output 
#if you want output form multiple instance then use [*]
#output "public_ip" {
#value = aws_instance.my_instance.public_ip 

#}

# this output block is when you use count meta argument 
# output "public_ip" {
#   value = aws_instance.my_instance[*].public_ip

# }

# output "private_ip" {
#   value = aws_instance.my_instance[*].private_ip

# }

# output "public_dns" {
#   value = aws_instance.my_instance[*].public_dns

# }

# this output block is for for_each

output "public_ip" {
  value = [
    for key in aws_instance.my_instance : key.public_ip
  ]
}

output "public_dns" {
  value = [
    for key in aws_instance.my_instance : key.public_dns
  ]

}

output "private_ip" {
  value = [
    for key in aws_instance.my_instance : key.private_ip
  ]

}