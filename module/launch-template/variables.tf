variable "asg_id" {
  description = "asg instance sg"
  type        = string
}

variable "key_name" {
  description = "key name of ec2"
  type        = string
}

variable "launch_template_name" {
  description = "name for launch template"
  type = string
  default = "terraform-launch-template"
}

variable "template_version" {
  description = "template version number"
  type = string
}

variable "template_instance_name" {
  description = "instance name launch in asg using launch template"
  type = string
  default = "alb-instance"
}

variable "template_ami" {
  description = "ami id used in template"
  type = string
}

variable "template_instance_type" {
  description = "instnace type used in template"
  type = string
}
