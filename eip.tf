resource "osc_eip" "cloud-media-adm-eip" {
  count 	    = 1
  network_interface = "${element(osc_instance.cloud-media-adm.*.network_interface_id, count.index)}"
  depends_on = ["osc_instance.cloud-media-adm"]
  vpc               = true
}

resource "osc_eip" "cloud-media-lb-eip" {
  count             = 1
  network_interface = "${element(osc_instance.cloud-media-lb.*.network_interface_id, count.index)}"
  vpc               = true
}

resource "osc_eip" "nat" {
  vpc               = true
}
