
#create launch template
resource "aws_launch_template" "launch_template" {
  name            = var.launch_template_name
  default_version = var.template_version
  description     = "launch template for nodejs server with port 3000"
  image_id        = var.template_ami
  instance_type   = var.template_instance_type
  key_name        = var.key_name
  user_data       = base64encode(file("./userdata.sh"))
  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [var.asg_id]
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = var.template_instance_name
    }
  }
}

