#CREATE ALB
resource "aws_lb" "alb" {
  count = 2
  name                       = var.alb_name
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [var.alb_Sg]
  subnets                    = [var.subnets[count.index]]
  # subnets                    = [var.public-subnet-1, var.public-subnet-2]
  enable_deletion_protection = false
}

resource "aws_vpc_security_group_ingress_rule" "allow_nodejs_port" {
  description       = "Allow HTTP traffic on port 3000 from alb sg"
  security_group_id = var.asg_id
  ip_protocol       = "tcp"
  from_port         = var.target_group_port
  to_port           = var.target_group_port
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
  port             = var.target_group_port
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
  port              = var.target_group_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_tg.arn
  }
}


#CREATE AUTO SCALING GROUP
resource "aws_autoscaling_group" "asg" {
  name                      = var.asg_name
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
  
  count = 2
  vpc_zone_identifier = [var.subnets[count.index+2]]

  instance_maintenance_policy {
    min_healthy_percentage = 100
    max_healthy_percentage = 110
  }
  depends_on = [ aws_lb.alb,aws_lb_target_group.lb_tg ]
}

