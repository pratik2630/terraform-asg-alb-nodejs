output "instance_id" {
  value = aws_instance.terraform_instance.id
}

output "public_ip" {
  value = aws_instance.terraform_instance.public_ip
}
output "key_name" {
    value = aws_key_pair.terraform-key.key_name
}