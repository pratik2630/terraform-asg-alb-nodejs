provider "aws" {
  region = "ap-south-1"
}

module "vpc" {
  source = "./module/vpc"
  # Pass any variables required by the VPC module
}

module "SG" {
  source = "./module/sg"
  vpc_id = module.vpc.vpc_id
}

module "ec2" {
  source       = "./module/ec2"
  vpc_id       = module.vpc.vpc_id
  pub_sub_1_id = module.vpc.pub_sub_1_id
  instance_Sg  = module.SG.sg_id
}

module "launch_template" {
  source   = "./module/launch-template"
  key_name = module.ec2.key_name
  asg_id   = module.SG.asg_instance_Sg
}

module "alb" {
  source           = "./module/alb"
  vpc_id           = module.vpc.vpc_id
  public-subnet-1  = module.vpc.pub_sub_1_id
  public-subnet-2  = module.vpc.pub_sub_2_id
  private-subnet-1 = module.vpc.priv_sub_1_id
  private-subnet-2 = module.vpc.priv_sub_2_id
  launch_template  = module.launch_template.launch_template
  asg_id           = module.SG.asg_instance_Sg
  alb_Sg           = module.SG.alb_Sg
}