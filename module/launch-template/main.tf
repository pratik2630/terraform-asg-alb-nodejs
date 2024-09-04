
#CREATE LAUNCH TEMPLATE
resource "aws_launch_template" "launch_template" {
  name            = "terraform-launch-template"
  default_version = "1"
  description     = "launch template for nodejs server with port 3000"
  image_id        = "ami-02b49a24cfb95941c"
  instance_type   = "t2.micro"
  key_name        = var.key_name
  user_data       = base64encode(file("G:/Terraform/ALB-terraform/module/launch-template/userdata.sh"))

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [var.asg_id]
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "bastion host"
    }
  }
}

variable "asg_id" {
  description = "asg instance sg"
  type        = string
}

variable "key_name" {
  description = "key name of ec2"
  type        = string
}

