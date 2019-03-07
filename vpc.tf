resource "osc_vpc" "vpc_cloud_media" {
  cidr_block = "10.0.0.0/16"
  tags {
    Name = "vpc_cloud_media"
  }
}
