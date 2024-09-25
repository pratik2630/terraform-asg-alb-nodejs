#vpc variables
vpc_cidr_block     = "10.0.0.0/16"
vpc_name           = "terraform-project-vpc"
subnet_names       = ["public-subnet-1", "public-subnet-2", "private-subnet-2"]
subnet_cidr        = ["10.0.0.0/20", "10.0.16.0/20", "10.0.128.0/20", "10.0.144.0/20"]
availability_zones = ["ap-south-1a", "ap-south-1b", "ap-south-1a", "ap-south-1b"]
igw_name           = "terraform-project-igw"
ngw_name           = "terraform-project-ngw"
igw_rt_name        = "terraform-project-rt"
ngw_rt_name        = "nat-gateway-terraform-project-rt"


#sg variables
bastion_sg_name = "terraform-instance-security-group"
asg_instance_sg = "terraform-asg-instance-security-group"
asg_sg          = "terraform-alb-security-group"

#bastion ec2 variables
pem_key               = "terraform_key"
key_location          = "C:/Users/Lenovo/.ssh/id_rsa.pub"
ami_id                = "ami-02b49a24cfb95941c"
instance_type         = "t2.micro"
private_key           = "C:/Users/Lenovo/.ssh/id_rsa"
ec2-user              = "ec2-user"
bastion_instance_name = "Terraform-instance-project"

#launch template variable
template_version       = "1"
launch_template_name   = "terraform-launch-template"
template_instance_name = "alb-instance"
template_ami           = "ami-02b49a24cfb95941c"
template_instance_type = "t2.micro"


#alb variables
alb_name          = "test-lb-tf"
target_group_port = 3000
asg_name          = "terraform-project-asg"
