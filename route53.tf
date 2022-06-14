resource "aws_route53_zone_association" "vpc" {
  zone_id = data.aws_route53_zone.internal.zone_id
  vpc_id  = aws_vpc.main.id
}
