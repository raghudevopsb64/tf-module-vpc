resource "aws_vpc" "main" {
  cidr_block           = var.VPC_CIDR_BLOCK
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name      = "${var.COMPONENT}-${var.ENV}"
    COMPONENT = var.COMPONENT
    ENV       = var.ENV
  }
}

