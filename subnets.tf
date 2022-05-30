resource "aws_subnet" "main" {
  count             = length(var.SUBNET_CIDR)
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.SUBNET_CIDR, count.index)
  availability_zone = element(var.AZ, count.index)

  tags = {
    Name = "${var.COMPONENT}-${var.ENV}-${count.index + 1}"
  }
}

