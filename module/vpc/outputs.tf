output "vpc_id" {
  value = aws_vpc.terraform_vpc.id
}
output "pub_sub_1_id" {
  value = aws_subnet.public-subnet-1.id
}
output "pub_sub_2_id" {
  value = aws_subnet.public-subnet-2
}
output "priv_sub_1_id" {
  value = aws_subnet.private-subnet-1
}
output "priv_sub_2_id" {
  value = aws_subnet.private-subnet-2
}