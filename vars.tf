variable profile {
  default = "mehmet"
}

variable region {
  default = "eu-west-2"
}

variable url_ec2 {
  default = "fcu.eu-west-2.outscale.com"
}

variable url_iam {
  default = "eim.eu-west-2.outscale.com"
}

variable url_lbu {
  default = "lbu.eu-west-2.outscale.com"
}

variable url_s3 {
  default = "osu.eu-west-2.outscale.com"
}

variable ami_centos7 {
  type    = "map"
  default = {
    id   = "ami-3e158364"
  }
}

