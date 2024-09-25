variable "pem_key" {
  description = "public key name for ec2"
  type = string
  default = "terraform-key"
}
variable "key_location" {
  description = "location of public key"
  type = string
  default = "C:/Users/Lenovo/.ssh/id_rsa.pub"
}
variable "ami_id" {
  description = "value of ami id"
  type = string
  default = "ami-02b49a24cfb95941c"
}
variable "instance_type" {
  description = "instance type for ec2"
  type = string
  default = "t2.micro"
}
variable "private_key" {
  description = "private key to connect with ssh"
  type = string
  default = "C:/Users/Lenovo/.ssh/id_rsa"
}
variable "ec2-user" {
  description = "ec2 user name for ssh connection"
  type = string
  default = "ec2-user"
}
variable "bastion_instance_name" {
  description = "name of bastion instance"
  type = string
  default = "Terraform-instance-project"
}
variable "vpc_id" {
  description = "vpc id"
  type = string
}
variable "public-subnet-1-id" {
  description = "public subnet id for ec2 instance"
  type        = string
}
variable "instance_Sg" {
  description = "security group for instance"
  type = string
}


