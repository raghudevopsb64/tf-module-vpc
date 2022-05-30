resource "aws_route_table" "route" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.COMPONENT}-${var.ENV}-rt"
  }
}

resource "aws_route_table_association" "subnet-rt-assoc" {
  count          = length(var.SUBNET_CIDR)
  subnet_id      = element(aws_subnet.main.*.id, count.index)
  route_table_id = aws_route_table.route.id
}

