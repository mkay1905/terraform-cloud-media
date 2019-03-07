resource "osc_internet_gateway" "internet_gateway" {
  vpc_id = "${osc_vpc.vpc_cloud_media.id}"
}
