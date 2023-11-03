
output "vpc_id" {
  value = aws_vpc.main_vpc.id
}

output "subnet_ids" {
  value = [
    aws_subnet.subnet_a.id, aws_subnet.subnet_b.id, aws_subnet.subnet_c.id, aws_subnet.subnet_d.id
  ]
}

output "private_subnet_ids" {
  value = [
    aws_subnet.subnet_c.id, aws_subnet.subnet_d.id
  ]
}

