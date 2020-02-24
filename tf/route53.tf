resource "aws_route53_zone" "external" {
  name = "novaprospekt.xyz"
}

resource "aws_route53_record" "www" {
  zone_id = "${data.aws_route53_zone.external.zone_id}"
  name    = "www.novaprospekt.xyz"
  type    = "A"

  alias {
    name                   = "${aws_elb.np-elb.dns_name}"
    zone_id                = "${aws_elb.np-elb.zone_id}"
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "apex" {
  zone_id = "${data.aws_route53_zone.external.zone_id}"
  name    = "novaprospekt.xyz"
  type    = "A"

  alias {
    name                   = "www.novaprospekt.xyz"
    zone_id                = "${data.aws_route53_zone.external.zone_id}"
    evaluate_target_health = true
  }
}

output "ns-servers" {
    value = "${aws_route53_zone.external.name_servers}"
}

