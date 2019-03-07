resource "osc_route_table" "public_routetable" {
  vpc_id = "${osc_vpc.vpc_cloud_media.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${osc_internet_gateway.internet_gateway.id}"
  }

  tags {
    label = "igw_to_internet"
  }
}

resource "osc_route_table" "private_routetable" {
  vpc_id = "${osc_vpc.vpc_cloud_media.id}"

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${osc_nat_gateway.nat_gateway.id}"
  }

  tags {
    label = "nat_to_igwt"
  }
}

resource "osc_route_table_association" "public_subnet_a" {
  subnet_id      = "${osc_subnet.public_subnet_a.id}"
  route_table_id = "${osc_route_table.public_routetable.id}"
}

resource "osc_route_table_association" "private_subnet_a" {
  subnet_id      = "${osc_subnet.private_subnet_a.id}"
  route_table_id = "${osc_route_table.private_routetable.id}"
}
