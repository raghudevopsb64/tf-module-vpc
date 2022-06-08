resource "aws_ec2_transit_gateway_vpc_attachment" "component-attach" {
  subnet_ids                                      = aws_subnet.main.*.id
  transit_gateway_id                              = data.terraform_remote_state.tgw.outputs.TRANSIT_GW
  transit_gateway_default_route_table_association = false
  transit_gateway_default_route_table_propagation = false
  vpc_id                                          = aws_vpc.main.id
  tags = {
    Name = "${var.COMPONENT}-tgw-attach-${var.ENV}"
  }
}


resource "aws_ec2_transit_gateway_route_table" "app-vpc" {
  transit_gateway_id = data.terraform_remote_state.tgw.outputs.TRANSIT_GW
  tags = {
    Name = "frontend-vpc"
  }
}

resource "aws_ec2_transit_gateway_route_table_association" "default-vpc-tgw-attach" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.component-attach.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.app-vpc.id
}

resource "aws_ec2_transit_gateway_route" "route-to-app-vpc" {
  destination_cidr_block         = "0.0.0.0/0"
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.component-attach.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.app-vpc.id
}

