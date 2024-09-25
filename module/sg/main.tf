#security group for bastion host instance
resource "aws_security_group" "instance_Sg" {
  name        = var.bastion_sg_name
  description = " security group for bastion host instance in terraform project"
  vpc_id      = var.vpc_id
  tags = {
    Name = var.bastion_sg_name
  }
}

#Inbound rule for ssh
resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  description       = "Allow SSH traffic on port 22"
  security_group_id = aws_security_group.instance_Sg.id
  ip_protocol       = "ssh"
  from_port         = 22
  to_port           = 22
  cidr_ipv4         = "0.0.0.0/0"
  tags = {
    Name = "Allow ssh"
  }
}

#outbound rule for all traffic
resource "aws_vpc_security_group_egress_rule" "allow_all_outbound_bastion" {
  security_group_id = aws_security_group.instance_Sg.id
  ip_protocol       = "-1" # "-1" means all protocols
  cidr_ipv4         = "0.0.0.0/0"
  description = "Allow all outbound traffic"
}

#security group for auto scaling groups ec2
resource "aws_security_group" "asg_instance_Sg" {
  name        = var.asg_instance_sg
  description = " security group for instance in auto scaling group of terraform project"
  vpc_id      = var.vpc_id
  tags = {
    Name = var.asg_instance_sg
  }
}

# create outbound rule allowing all traffic
resource "aws_vpc_security_group_egress_rule" "allow_all_outbound" {
  security_group_id = aws_security_group.asg_instance_Sg.id
  ip_protocol       = "-1" # "-1" means all protocols
  cidr_ipv4         = "0.0.0.0/0"
  description = "Allow all outbound traffic"
}

#security group for alb
resource "aws_security_group" "alb_Sg" {
  name        = var.asg_sg
  description = " security group for alb in terraform project"
  vpc_id      = var.vpc_id
  tags = {
    Name = var.asg_sg
  }
}


# Ingress rule to allow http traffic
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

# outbound rule for all traffic
resource "aws_vpc_security_group_egress_rule" "allow_all_alb_outbound" {
  security_group_id = aws_security_group.alb_Sg.id
  ip_protocol       = "-1" # "-1" means all protocols
  cidr_ipv4         = "0.0.0.0/0"
  description = "Allow all outbound traffic"
}

