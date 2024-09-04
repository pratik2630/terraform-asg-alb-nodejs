#CREATE ALB
resource "aws_lb" "alb" {
  name                       = "test-lb-tf"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [var.alb_Sg]
  subnets                    = [var.public-subnet-1, var.public-subnet-2]
  enable_deletion_protection = false
}

resource "aws_vpc_security_group_ingress_rule" "allow_nodejs_port" {
  description       = "Allow HTTP traffic on port 3000 from alb sg"
  security_group_id = var.asg_id
  ip_protocol       = "tcp"
  from_port         = 3000
  to_port           = 3000
  referenced_security_group_id = var.alb_Sg
  tags = {
    Name = "Allow node js port 3000"
  }
  depends_on = [ var.alb_Sg ,aws_autoscaling_group.asg ]
}


#CREATE TARGET GROUP FOR LOAD BALANCER
resource "aws_lb_target_group" "lb_tg" {
  name             = "terraform-project-target-group"
  target_type      = "instance" #by default
  port             = 3000
  protocol         = "HTTP"
  protocol_version = "HTTP1"
  vpc_id           = var.vpc_id
  health_check {
    path                = "/"
    port                = "traffic-port"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}
#ADD LISTENER TARGET GROUP TO LOAD BALANCER
resource "aws_lb_listener" "nodejs-listner" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "3000"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_tg.arn
  }
}


#CREATE AUTO SCALING GROUP
resource "aws_autoscaling_group" "asg" {
  name                      = "terraform-project-asg"
  max_size                  = 3
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "ELB"
  metrics_granularity       = "1Minute"
  default_instance_warmup   = 300
  desired_capacity          = 1
  force_delete              = true
  target_group_arns         = [aws_lb_target_group.lb_tg.arn] #check again
  termination_policies      = ["Default"]
  protect_from_scale_in     = false

  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupPendingInstances",
    "GroupStandbyInstances",
    "GroupTerminatingInstances",
    "GroupTotalInstances",
  ]

  launch_template {
    id      = var.launch_template
    version = "$Latest"
  }
  
  vpc_zone_identifier = [var.private-subnet-1, var.private-subnet-2]

  instance_maintenance_policy {
    min_healthy_percentage = 100
    max_healthy_percentage = 110
  }
  depends_on = [ aws_lb.alb,aws_lb_target_group.lb_tg ]
}


variable "launch_template" {
  description = "launch template"
  type = string
}

variable "asg_id" {
  description = "security group for autoscaling group"
  type = string
}

variable "alb_Sg" {
  description = "security group for alb"
  type = string
}

variable "vpc_id" {
  description = "The VPC ID to associate with the terraform vpc"
  type        = string
}

variable "public-subnet-1" {
 description = "public subnet 1" 
 type = string
}

variable "public-subnet-2" {
 description = "public subnet 2" 
 type = string
}

variable "private-subnet-1" {
  description = "private subnet 1 id"
  type        = string
}

variable "private-subnet-2" {
  description = "private subnet 2 id"
  type        = string
}

