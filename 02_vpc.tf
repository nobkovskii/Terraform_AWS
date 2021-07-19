resource "aws_vpc" "vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.project}-VPC"
    Owner = var.owner
    Project = var.project
  }
}

resource "aws_subnet" "public_subnet" {
  cidr_block              = "10.0.0.0/24"
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project}-Public_Subnet"
    Owner = var.owner
    Project = var.project
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.project}-InternetGateway"
    Owner = var.owner
    Project = var.project
  }
}

resource "aws_route_table" "route_table_public" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = "${var.project}-Public_RouteTable"
    Owner = var.owner
    Project = var.project
  }
}

resource "aws_route_table_association" "rt_association_public" {
  route_table_id = aws_route_table.route_table_public.id
  subnet_id      = aws_subnet.public_subnet.id
}

resource "aws_security_group" "bastion_security_group" {
  name        = "bastion-sg"
  vpc_id      = aws_vpc.vpc.id
  description = "security group for bastion"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] // Set Your GlobalIP(IP v4)
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.project}-Bastion_SecurityGroup"
    Owner = var.owner
    Project = var.project
  }
}

# Private Subnet
resource "aws_subnet" "private_subnet" {
  cidr_block        = "10.0.10.0/24"
  vpc_id            = aws_vpc.vpc.id
  availability_zone = "ap-northeast-1a"

  tags = {
    Name = "${var.project}-Private_Subnet"
    Owner = var.owner
    Project = var.project
  }
}

# Elastic IP for Nat Gateway
resource "aws_eip" "for_nat_gateway" {
  vpc = true

  tags = {
    Name = "${var.project}-NatGateway_EIP"
    Owner = var.owner
    Project = var.project
  }
}

# Nat Gateway
# Internet Gateway <- Nat Gateway(public) <- Private Subnet
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.for_nat_gateway.id
  subnet_id     = aws_subnet.public_subnet.id

  tags = {
    Name = "${var.project}-NatGateway"
    Owner = var.owner
    Project = var.project
  }
}

# Route Table for Private Subnet
resource "aws_route_table" "route_table_private" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }

  tags = {
    Name = "${var.project}-Private_Subnet"
    Owner = var.owner
    Project = var.project
  }
}

resource "aws_route_table_association" "rt_association_private" {
  route_table_id = aws_route_table.route_table_private.id
  subnet_id      = aws_subnet.private_subnet.id
}

# Security Group for Private
# OK : Bastion -> ssh -> private
resource "aws_security_group" "private_security_group" {
  name        = "private-sg"
  vpc_id      = aws_vpc.vpc.id
  description = "security group for private"

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion_security_group.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project}-Private_SecurityGroup"
    Owner = var.owner
    Project = var.project
  }
}