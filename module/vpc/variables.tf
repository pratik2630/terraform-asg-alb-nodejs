variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default = "10.0.0.0/16"
}
variable "vpc_name" {
  description = "name for the VPC"
  type        = string
  default = "terraform-project-vpc"
}
variable "igw_name" {
  description = "name for internet gateway"
  type = string
  default = "terraform-project-igw"
}
variable "ngw_name" {
  description = "name for nat gateway"
  type = string
  default = "terraform-project-ngw"
}
variable "igw_rt_name" {
  description = "name for internet gateway route table"
  type = string
  default = "terraform-project-rt"
}
variable "ngw_rt_name" {
  description = "name for nat gateway route table"
  type = string
  default = "nat-gateway-terraform-project-rt"
}

variable "subnet_names" {
  description = "names of subnets"
  type = list(string)
}

variable "subnet_cidr" {
  description = "cidr of subnets"
  type = list(string)
}

variable "availability_zones" {
  description = "List of availability zones for subnets"
  type        = list(string)
}

