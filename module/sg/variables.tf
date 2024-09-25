variable "bastion_sg_name" {
  description = "name for aws security group used for bastion host "
  type = string
  default = "terraform-instance-security-group"
}

variable "asg_instance_sg" {
  description = " security group for instance in auto scaling group of terraform project"
  type = string
  default = "terraform-asg-instance-security-group"
}

variable "asg_sg" {
  description = " security group for alb "
  type = string
  default = "terraform-alb-security-group"
}

variable "vpc_id" {
  description = "The VPC ID to associate with the terraform vpc"
  type        = string
}