resource "osc_nat_gateway" "nat_gateway" {
  allocation_id = "${osc_eip.nat.id}"
  subnet_id     = "${osc_subnet.public_subnet_a.id}"
  depends_on    = ["osc_route_table_association.public_subnet_a"]
}
