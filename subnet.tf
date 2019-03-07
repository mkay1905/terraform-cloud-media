resource "osc_subnet" "public_subnet_a" {
  vpc_id                  = "${osc_vpc.vpc_cloud_media.id}"
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "${var.region}a"

  tags {
    Name = "public subnet cloud media"
  }
}

resource "osc_subnet" "private_subnet_a" {
  vpc_id                  = "${osc_vpc.vpc_cloud_media.id}"
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "${var.region}a"

  tags {
    Name = "private subnet cloud media"
  }
}
