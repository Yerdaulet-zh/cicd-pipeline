resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = local.subnet_public_cidr
  availability_zone       = "${local.region}a"
  map_public_ip_on_launch = true

  tags = {
    Name = "${local.project_name}-public-subnet"
  }
}

resource "aws_subnet" "private" {
  for_each = local.private_subnets_cidrs

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = each.key
  availability_zone = "${local.region}${each.value}"

  tags = {
    Name = "${local.project_name}-private-subnets"
  }
}
