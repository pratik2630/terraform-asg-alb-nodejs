#CREATE VPC
resource "aws_vpc" "terraform_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "terraform-project-vpc"
  }

}

#CREATE SUBNET

#---> PUBLIC SUBNET 1
resource "aws_subnet" "public-subnet-1" {
  vpc_id                  = aws_vpc.terraform_vpc.id
  cidr_block              = "10.0.0.0/20"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "terraform-project-public-subnet-1"
  }
}

#--->PUBLIC SUBNET 2
resource "aws_subnet" "public-subnet-2" {
  vpc_id                  = aws_vpc.terraform_vpc.id
  cidr_block              = "10.0.16.0/20"
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "terraform-project-public-subnet-2"
  }
}

#--->PRIVATE SUBNET 1
resource "aws_subnet" "private-subnet-1" {
  vpc_id                  = aws_vpc.terraform_vpc.id
  cidr_block              = "10.0.128.0/20"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "terraform-project-private-subnet-1"
  }
}

#--->PRIVATE SUBNET 2
resource "aws_subnet" "private-subnet-2" {
  vpc_id                  = aws_vpc.terraform_vpc.id
  cidr_block              = "10.0.144.0/20"
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "terraform-project-private-subnet-2"
  }
}

#--->CREATING INTERNET GATEWAY FOR PUBLIC SUBNET
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.terraform_vpc.id

  tags = {
    Name = "terraform-project-igw"
  }
}

#--->CREATE ROUTE TABLE FOR INTERNET GATEWAY
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.terraform_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "terraform-project-rt"
  }
}

#--->ASSOCIATE PUBLIC SUBNET 1 WITH INTERNET GATEWAY ROUTE TABLE
resource "aws_route_table_association" "rta1" {
  subnet_id      = aws_subnet.public-subnet-1.id
  route_table_id = aws_route_table.rt.id
}

#--->ASSOCIATE PUBLIC SUBNET 2 WITH INTERNET GATEWAY ROUTE TABLE
resource "aws_route_table_association" "rta2" {
  subnet_id      = aws_subnet.public-subnet-2.id
  route_table_id = aws_route_table.rt.id
}

#---> Creating Elastic ip
resource "aws_eip" "ngw" {
  domain   = "vpc"
}

#--->CREATING NAT GATEWAY

resource "aws_nat_gateway" "ngw" {

  subnet_id =  aws_subnet.public-subnet-1
  allocation_id = aws_eip.ngw.allocation_id
  tags = {
    Name = "terraform-project-ngw"
  }
  depends_on = [ aws_internet_gateway.gw ]
}

#--->CREATE ROUTE TABLE FOR NAT GATEWAY
resource "aws_route_table" "rt2" {
  vpc_id = aws_vpc.terraform_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw.id
  }

  tags = {
    Name = "nat-gateway-terraform-project-rt"
  }
}

#--->ASSOCIATE PRIVATE SUBNET 1 WITH NAT GATEWAY ROUTE TABLE
resource "aws_route_table_association" "rta3" {
  subnet_id      = aws_subnet.private-subnet-1.id
  route_table_id = aws_route_table.rt2.id
}

#--->ASSOCIATE PRIVATE SUBNET 2 WITH NAT GATEWAY ROUTE TABLE
resource "aws_route_table_association" "rta4" {
  subnet_id      = aws_subnet.private-subnet-2.id
  route_table_id = aws_route_table.rt2.id
}


# output "vpc_id" {
#   value = aws_vpc.terraform_vpc.id
# }
# output "pub_sub_1_id" {
#   value = aws_subnet.public-subnet-1.id
# }
# output "pub_sub_2_id" {
#   value = aws_subnet.public-subnet-2
# }
# output "priv_sub_1_id" {
#   value = aws_subnet.private-subnet-1
# }
# output "priv_sub_2_id" {
#   value = aws_subnet.private-subnet-2
# }