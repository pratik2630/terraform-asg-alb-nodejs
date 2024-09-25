provider "aws" {
  region = "ap-south-1"
}

module "vpc" {
  source = "./module/vpc"
  # Pass any variables required by the VPC module
  availability_zones = var.availability_zones
  subnet_names       = var.subnet_names
  subnet_cidr        = var.subnet_cidr
}

module "SG" {
  source = "./module/sg"
  vpc_id = module.vpc.vpc_id
}

module "ec2" {
  source             = "./module/ec2"
  vpc_id             = module.vpc.vpc_id
  public-subnet-1-id = element(module.vpc.subnet_ids, 0)
  instance_Sg        = module.SG.sg_id
}

# module "launch_template" {
#   source                 = "./module/launch-template"
#   template_ami           = var.template_ami
#   template_version       = var.template_version
#   template_instance_type = var.template_instance_type
#   key_name               = module.ec2.key_name
#   asg_id                 = module.SG.asg_instance_Sg
# }

# module "alb" {
#   source = "./module/alb"
#   vpc_id = module.vpc.vpc_id
#   subnets           = module.vpc.subnet_ids
#   launch_template   = module.launch_template.launch_template
#   asg_id            = module.SG.asg_instance_Sg
#   alb_Sg            = module.SG.alb_Sg
#   alb_name          = var.alb_name
#   target_group_port = var.target_group_port
#   asg_name          = var.asg_name

# }