resource "osc_instance" "cloud-media-adm" {
  count                       = 1
  ami                         = "${var.ami_centos7["id"]}"
  availability_zone           = "${var.region}a"
  instance_type               = "t2.medium"
  key_name                    = "mehmet_outscale"
  subnet_id                   = "${osc_subnet.public_subnet_a.id}"
  private_ip                  = "10.0.0.50"
  associate_public_ip_address = true
  tags {
    Name = "cloud_media_adm" 
  }
}

resource "osc_instance" "cloud-media-lb" {
  count                       = 1
  ami                         = "${var.ami_centos7["id"]}"
  availability_zone           = "${var.region}a"
  instance_type               = "t2.small"
  key_name                    = "mehmet_outscale"
  subnet_id                   = "${osc_subnet.public_subnet_a.id}"
  private_ip                  = "10.0.0.51"
  tags {
    Name = "cloud_media_lb"
  }
}


resource "osc_instance" "cloud-media-plex" {
  count                       = 1
  ami                         = "${var.ami_centos7["id"]}"
  availability_zone           = "${var.region}a"
  instance_type               = "c4.xlarge"
  key_name                    = "mehmet_outscale"
  subnet_id                   = "${osc_subnet.private_subnet_a.id}"
  private_ip                  = "10.0.1.10"
  tags {
    Name = "cloud_media_plex"
  }
}
