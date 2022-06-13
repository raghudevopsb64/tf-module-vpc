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


//resource "aws_ec2_transit_gateway_route_table" "app-vpc" {
//  transit_gateway_id = data.terraform_remote_state.tgw.outputs.TRANSIT_GW
//  tags = {
//    Name = "${var.COMPONENT}-vpc"
//  }
//}

//resource "aws_ec2_transit_gateway_route_table_association" "default-vpc-tgw-attach" {
//  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.component-attach.id
//  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.app-vpc.id
//}

//resource "aws_ec2_transit_gateway_route" "route-to-app-vpc" {
//  destination_cidr_block         = "0.0.0.0/0"
//  transit_gateway_attachment_id  = data.terraform_remote_state.tgw.outputs.DEFAULT_VPC_TRANSIT_GW_ATTACHMENT
//  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.app-vpc.id
//}

//resource "aws_ec2_transit_gateway_route" "route-from-default-vpc-to-component-vpc" {
//  destination_cidr_block         = var.VPC_CIDR_BLOCK
//  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.component-attach.id
//  transit_gateway_route_table_id = data.terraform_remote_state.tgw.outputs.DEFAULT_VPC_TRANSIT_GW_ROUTE_TABLE
//}


resource "aws_ec2_transit_gateway_route_table_association" "component-vpc-tgw-attach" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.component-attach.id
  transit_gateway_route_table_id = data.terraform_remote_state.tgw.outputs.APP_VPC_TRANSIT_GW_ROUTE_TABLE
}

//resource "aws_ec2_transit_gateway_route" "route-from-default-vpc-to-component-vpc" {
//  destination_cidr_block         = var.VPC_CIDR_BLOCK
//  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.component-attach.id
//  transit_gateway_route_table_id = data.terraform_remote_state.tgw.outputs.APP_VPC_TRANSIT_GW_ROUTE_TABLE
//}
