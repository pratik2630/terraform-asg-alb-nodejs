
#--->CREATE SECURITY GROUP  FOR  BASTION EC2 INSTANCE
resource "aws_security_group" "instance_Sg" {
  name        = "terraform-sg-security-group"
  description = " security group for bastion host instance in terraform project"
  vpc_id      = var.vpc_id

  tags = {
    Name = "terraform-instance-security-group"
  }
}

# Define ingress rules separately

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  description       = "Allow HTTP traffic on port 3000"
  security_group_id = aws_security_group.instance_Sg.id
  ip_protocol       = "ssh"
  from_port         = 22
  to_port           = 22
  cidr_ipv4         = "0.0.0.0/0"
  tags = {
    Name = "Allow ssh"
  }
}


# CREATE OUTBOUND RULE ALLOWING ALL TRAFFIC
resource "aws_vpc_security_group_egress_rule" "allow_all_outbound_bastion" {
  security_group_id = aws_security_group.instance_Sg.id
  ip_protocol       = "-1" # "-1" means all protocols
  cidr_ipv4         = "0.0.0.0/0"

  description = "Allow all outbound traffic"
}


#======================================================================

#--->CREATE SECURITY GROUP  FOR  AUTO SCALING GROUP EC2 INSTANCE
resource "aws_security_group" "asg_instance_Sg" {
  name        = "terraform-asg-sg-security-group"
  description = " security group for instance in auto scaling group of terraform project"
  vpc_id      = var.vpc_id

  tags = {
    Name = "terraform-asg-instance-security-group"
  }
}

# CREATE OUTBOUND RULE ALLOWING ALL TRAFFIC
resource "aws_vpc_security_group_egress_rule" "allow_all_outbound" {
  security_group_id = aws_security_group.asg_instance_Sg.id
  ip_protocol       = "-1" # "-1" means all protocols
  cidr_ipv4         = "0.0.0.0/0"

  description = "Allow all outbound traffic"
}


#================================================================================
#--->CREATE SECURITY GROUP FOR ALB
resource "aws_security_group" "alb_Sg" {
  name        = "terraform-alb-sg-security-group"
  description = " security group for alb in terraform project"
  vpc_id      = var.vpc_id

  tags = {
    Name = "terraform-alb-security-group"
  }
}

# Define ingress rules separately
resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  description       = "Allow HTTP traffic"
  security_group_id = aws_security_group.alb_Sg.id
  ip_protocol       = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_ipv4         = "0.0.0.0/0"
  tags = {
    Name = "Allow HTTP traffic"
  }
}

# CREATE OUTBOUND RULE ALLOWING ALL TRAFFIC
resource "aws_vpc_security_group_egress_rule" "allow_all_alb_outbound" {
  security_group_id = aws_security_group.alb_Sg.id
  ip_protocol       = "-1" # "-1" means all protocols
  cidr_ipv4         = "0.0.0.0/0"

  description = "Allow all outbound traffic"
}

variable "vpc_id" {
  description = "The VPC ID to associate with the terraform vpc"
  type        = string
}