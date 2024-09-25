#vpc variables
variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}
variable "vpc_name" {
  description = "name for the VPC"
  type        = string
  default     = "terraform-project-vpc"
}

variable "subnet_names" {
  description = "names of subnets"
  type        = list(string)
}

variable "subnet_cidr" {
  description = "cidr of subnets"
  type        = list(string)
}

variable "availability_zones" {
  description = "List of availability zones for subnets"
  type        = list(string)
}

variable "igw_name" {
  description = "name for internet gateway"
  type        = string
  default     = "terraform-project-igw"
}
variable "ngw_name" {
  description = "name for nat gateway"
  type        = string
  default     = "terraform-project-ngw"
}
variable "igw_rt_name" {
  description = "name for internet gateway route table"
  type        = string
  default     = "terraform-project-rt"
}
variable "ngw_rt_name" {
  description = "name for nat gateway route table"
  type        = string
  default     = "nat-gateway-terraform-project-rt"
}

variable "subnet_ids" {
  description = "ids of all available subnets"
  type        = list(string)
}

#sg variables
variable "bastion_sg_name" {
  description = "name for aws security group used for bastion host "
  type        = string
  default     = "terraform-instance-security-group"
}

variable "asg_instance_sg" {
  description = " security group for instance in auto scaling group of terraform project"
  type        = string
  default     = "terraform-asg-instance-security-group"
}

variable "asg_sg" {
  description = " security group for alb "
  type        = string
  default     = "terraform-alb-security-group"
}

variable "vpc_id" {
  description = "The VPC ID to associate with the terraform vpc"
  type        = string
}

#ec2 variables

variable "pem_key" {
  description = "public key name for ec2"
  type        = string
  default     = "terraform-key"
}

variable "key_location" {
  description = "location of public key"
  type        = string
  default     = "C:/Users/Lenovo/.ssh/id_rsa.pub"
}

variable "ami_id" {
  description = "value of ami id"
  type        = string
  default     = "ami-02b49a24cfb95941c"
}

variable "instance_type" {
  description = "instance type for ec2"
  type        = string
  default     = "t2.micro"
}

variable "private_key" {
  description = "private key to connect with ssh"
  type        = string
  default     = "C:/Users/Lenovo/.ssh/id_rsa"
}

variable "ec2-user" {
  description = "ec2 user name for ssh connection"
  type        = string
  default     = "ec2-user"
}

variable "bastion_instance_name" {
  description = "name of bastion instance"
  type        = string
  default     = "Terraform-instance-project"
}


variable "pub_sub_1_id" {
  description = "public subnet id for ec2 instance"
  type        = string
}

variable "instance_Sg" {
  description = "security group for instance"
  type        = string
}

#launch template


variable "key_name" {
  description = "key name of ec2"
  type        = string
}

variable "launch_template_name" {
  description = "name for launch template"
  type        = string
  default     = "terraform-launch-template"
}

variable "template_version" {
  description = "template version number"
  type        = string
}

variable "template_instance_name" {
  description = "instance name launch in asg using launch template"
  type        = string
  default     = "alb-instance"
}

variable "template_ami" {
  description = "ami id used in template"
  type        = string
}

variable "template_instance_type" {
  description = "instnace type used in template"
  type        = string
}

#alb variables
variable "alb_name" {
  description = "name of aws alb"
  type        = string
}

variable "target_group_port" {
  description = "port number used for target group"
  type        = number
}

variable "asg_name" {
  description = "asg name"
  type        = string
}

variable "launch_template" {
  description = "launch template"
  type        = string
}

variable "asg_id" {
  description = "security group for autoscaling group"
  type        = string
}

variable "alb_Sg" {
  description = "security group for alb"
  type        = string
}

variable "public-subnet-1" {
  description = "public subnet 1"
  type        = string
}

variable "public-subnet-2" {
  description = "public subnet 2"
  type        = string
}

variable "private-subnet-1" {
  description = "private subnet 1 id"
  type        = string
}

variable "private-subnet-2" {
  description = "private subnet 2 id"
  type        = string
}

