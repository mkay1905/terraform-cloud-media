provider "osc" {
  profile                     = "${var.profile}"
  region                      = "${var.region}"
  skip_region_validation      = true

  endpoints {
    ec2 = "${var.url_ec2}"
    iam = "${var.url_iam}"
    elb = "${var.url_lbu}"
    s3  = "${var.url_s3}"
  }
}

