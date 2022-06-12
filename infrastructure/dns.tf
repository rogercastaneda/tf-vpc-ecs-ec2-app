# data "aws_route53_zone" "zone" {
#   name = "mydomain.com."
#   # private_zone = true
# }

# resource "aws_route53_record" "www" {
#   zone_id = data.aws_route53_zone.zone.zone_id
#   name    = "app.${data.aws_route53_zone.zone.name}"
#   type    = "A"
#   # ttl     = "300"
#   alias {
#     name                   = aws_alb.default.dns_name
#     zone_id                = aws_alb.default.zone_id
#     evaluate_target_health = true
#   }
# }
