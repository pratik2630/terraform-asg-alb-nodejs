output "sg_id" {
    value = aws_security_group.instance_Sg.id
}
output "asg_instance_Sg" {
    value = aws_security_group.asg_instance_Sg.id
}

output "alb_Sg" {
    value = aws_security_group.alb_Sg.id
}