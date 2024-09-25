variable "alb_name" {
  description = "name of aws alb"
  type = string
}

variable "target_group_port" {
  description = "port number used for target group"
  type = number
}

variable "asg_name" {
  description = "asg name"
  type = string
}

variable "launch_template" {
  description = "launch template"
  type = string
}

variable "asg_id" {
  description = "security group for autoscaling group"
  type = string
}

variable "alb_Sg" {
  description = "security group for alb"
  type = string
}

variable "vpc_id" {
  description = "The VPC ID to associate with the terraform vpc"
  type        = string
}

variable "subnets" {
  description = "all subnet ids"
  type = list(string)
}
