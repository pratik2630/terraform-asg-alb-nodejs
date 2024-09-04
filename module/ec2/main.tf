#CREATE AWS KEY PAIR
#First create key using command : ssh-keygen
resource "aws_key_pair" "terraform-key" {
  key_name   = "terraform-key"
  public_key = file("C:/Users/Lenovo/.ssh/id_rsa.pub ")
}

resource "aws_instance" "terraform_instance" {
  ami                         = "ami-02b49a24cfb95941c"
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.terraform-key.key_name
  subnet_id                   = var.pub_sub_1_id
  associate_public_ip_address = true
  vpc_security_group_ids = [var.instance_Sg]
  user_data = base64encode(file("./module/ec2/userdata.sh"))
  connection {
    type        = "ssh"
    user        = "ec2-user"                          # Replace with the appropriate username for your EC2 instance
    private_key = file("C:/Users/Lenovo/.ssh/id_rsa") # Replace with the path to your private key
    host        = self.public_ip
  }
  tags = {
    Name = "Terraform-instance-project"
  }
}

variable "vpc_id" {
  description = "vpc id"
  type = string
}

variable "pub_sub_1_id" {
  description = "public subnet id for ec2 instance"
  type        = string
}

variable "instance_Sg" {
  description = "security group for instance"
  type = string
}


