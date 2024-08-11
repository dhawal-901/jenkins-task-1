
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.10.0.0/16"

  enable_dns_hostnames = true
  tags = {
    Name = "VPC_Jenkins"
  }
}
resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.10.1.0/24"
  availability_zone = "ap-south-1a"
  tags = {
    Name = "PUBLIC_SUBNET_Jenkins"
  }
  depends_on = [aws_vpc.my_vpc]
}

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "IGW_Jenkins"
  }
  depends_on = [aws_vpc.my_vpc]
}

resource "aws_route_table" "my_public_rt" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }

  tags = {
    Name = "PUBLIC_RT_Jenkins"
  }
  depends_on = [aws_vpc.my_vpc, aws_internet_gateway.my_igw]
}

resource "aws_route_table_association" "my_public_subnet_rt_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.my_public_rt.id
  depends_on     = [aws_subnet.public_subnet, aws_route_table.my_public_rt]
}