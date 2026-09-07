data "aws_availability_zones" "available" {}

resource "aws_vpc" "vpc-tf" {
  cidr_block           = var.vpc_cidr
  # enable_dns_support   = true
  # enable_dns_hostnames = true

  tags = merge(
    var.tags,
    { Name = "NTL-vpc" }
  )
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc-tf.id

  tags = merge(
    var.tags,
    { Name = "NTL-igw" }
  )
}

# Public Subnets
resource "aws_subnet" "public" {
  count                   = length(var.public_subnets)
  vpc_id                  = aws_vpc.vpc-tf.id
  cidr_block              = var.public_subnets[count.index]
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true

  tags = merge(
    var.tags,
    { Name = "NTL-public-subnet-${count.index + 1}" }
  )
}

# Private Subnets
resource "aws_subnet" "private" {
  count             = length(var.private_subnets)
  vpc_id            = aws_vpc.vpc-tf.id
  cidr_block        = var.private_subnets[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = merge(
    var.tags,
    { Name = "NTL-private-subnet-${count.index + 1}" }
  )
}

# Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc-tf.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge(
    var.tags,
    { Name = "NTL-public-rt" }
  )
}

# Associate public subnets with route table
resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}
