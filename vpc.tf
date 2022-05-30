resource "aws_vpc" "main" {
  cidr_block = var.VPC_CIDR_BLOCK
  tags = {
    Name      = "${var.COMPONENT}-${var.ENV}"
    COMPONENT = var.COMPONENT
    ENV       = var.ENV
  }
}

