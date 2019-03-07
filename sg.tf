resource "osc_default_security_group" "default" {
  vpc_id = "${osc_vpc.vpc_cloud_media.id}"
  ingress {
    protocol  = "tcp"
    self      = true
    from_port = 22
    to_port   = 22
    cidr_blocks = ["10.0.0.0/16"]
    }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 1
    to_port     = 65535
    protocol    = "tcp"
    self        = "True"
  }


}

