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
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = local.subnet_private_cidr
  availability_zone = "${local.region}a"

  tags = {
    Name = "${local.project_name}-private-subnet"
  }
}
