# VPC
resource "aws_vpc" "default" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "vpc-${var.environment}"
    Environment = var.environment
  }
}

# Subnets
resource "aws_subnet" "public" {
  for_each          = var.public_subnets
  vpc_id            = aws_vpc.default.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az

  tags = {
    Name        = "subnet-${var.environment}-${each.key}"
    Environment = var.environment
  }
}

resource "aws_subnet" "private" {
  for_each          = var.private_subnets
  vpc_id            = aws_vpc.default.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az

  tags = {
    Name        = "subnet-${var.environment}-${each.key}"
    Environment = var.environment
  }
}

# Gateways
resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.default.id

  tags = {
    Name        = "internet-gateway-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_eip" "nat_gateway" {
  for_each   = var.public_subnets
  vpc        = true
  depends_on = [aws_internet_gateway.default]

  tags = {
    Name        = "epi-nat-gateway-${var.environment}-${each.key}"
    Environment = var.environment
  }
}

resource "aws_nat_gateway" "default" {
  for_each      = aws_eip.nat_gateway
  allocation_id = each.value.id
  subnet_id     = aws_subnet.public[each.key].id
  depends_on = [
    aws_internet_gateway.default
  ]

  tags = {
    Name        = "nat-gateway-${var.environment}-${each.key}"
    Environment = var.environment
  }
}

# Route tables
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.default.id

  tags = {
    Name        = "route-table-${var.environment}-public"
    Environment = var.environment
  }
}

resource "aws_route_table" "private" {
  for_each = aws_subnet.private
  vpc_id   = aws_vpc.default.id

  tags = {
    Name        = "route-table-${var.environment}-${each.key}"
    Environment = var.environment
  }
}

# Routes
resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  gateway_id             = aws_internet_gateway.default.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route" "private" {
  for_each               = aws_route_table.private
  route_table_id         = each.value.id
  gateway_id             = aws_nat_gateway.default[keys(aws_nat_gateway.default)[index(keys(aws_route_table.private), each.key)]].id
  destination_cidr_block = "0.0.0.0/0"

  lifecycle {
    ignore_changes = [gateway_id]
  }
}

# Route associations
resource "aws_route_table_association" "public" {
  for_each       = aws_subnet.public
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  for_each       = aws_subnet.private
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private[each.key].id
}
