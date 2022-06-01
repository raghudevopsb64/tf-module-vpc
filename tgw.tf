resource "aws_ec2_transit_gateway_vpc_attachment" "component-attach" {
  subnet_ids         = aws_subnet.main.*.id
  transit_gateway_id = data.terraform_remote_state.tgw.outputs.TRANSIT_GW
  vpc_id             = aws_vpc.main.id
  tags = {
    Name = "${var.COMPONENT}-tgw-attach-${var.ENV}"
  }
}
