# create vpc
resource "aws_vpc" "terraform_vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = var.vpc_name
  }
}

# subnets - public-subnet-1 , public-subnet-2 , private-subnet-1,private-subnet-2
resource "aws_subnet" "subnet" {
  count = length(var.subnet_names)
  vpc_id                  = aws_vpc.terraform_vpc.id
  cidr_block              = var.subnet_cidr[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = var.subnet_names[count.index]
  }
}

# Internet gateway 
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.terraform_vpc.id
  tags = {
    Name = var.igw_name
  }
}

#route table for internet gateway
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.terraform_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = var.igw_rt_name
  }
}

#associate public subnet 1 and 2 with internet gateway route table
resource "aws_route_table_association" "rta1" {
  count = 2
  subnet_id      = aws_subnet.var.subnet_names[count.index].id
  route_table_id = aws_route_table.rt.id
}

# creating elastic ip
resource "aws_eip" "ngw" {
  domain   = "vpc"
}

# creating nat gateway
resource "aws_nat_gateway" "ngw" {
  subnet_id =  aws_subnet.public-subnet-1
  allocation_id = aws_eip.ngw.allocation_id
  tags = {
    Name = var.ngw_name
  }
  depends_on = [ aws_internet_gateway.gw ]
}

#create route table for nat gateway
resource "aws_route_table" "rt2" {
  vpc_id = aws_vpc.terraform_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw.id
  }
  tags = {
    Name = var.ngw_rt_name
  }
}

#associate private subnet 1 with nat gateway route table
resource "aws_route_table_association" "rta2" {
  count = 2
  subnet_id      = aws_subnet.var.subnet_names[count.index + 2].id
  route_table_id = aws_route_table.rt2.id
}