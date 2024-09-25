#CREATE AWS KEY PAIR
#First create key using command : ssh-keygen
resource "aws_key_pair" "terraform-key" {
  key_name   = var.pem_key
  public_key = file(var.key_location)
}

resource "aws_instance" "terraform_instance" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.terraform-key.key_name
  subnet_id                   = var.public-subnet-1-id
  associate_public_ip_address = true
  vpc_security_group_ids = [var.instance_Sg]
  user_data = base64encode(file("./module/ec2/userdata.sh"))
  connection {
    type        = "ssh"
    user        = var.ec2-user                          # Replace with the appropriate username for your EC2 instance
    private_key = file(var.private_key) # Replace with the path to your private key
    host        = self.public_ip
  }
  tags = {
    Name = var.bastion_instance_name
  }
}


