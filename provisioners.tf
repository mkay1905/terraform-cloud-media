resource "null_resource" "configure_adm" {
    triggers {
        instance = "${osc_instance.cloud-media-adm.id}"
    }
  connection {
    host        = "${osc_instance.cloud-media-adm.public_ip}"
    user        = "outscale"
    timeout     = "60s"
    private_key = "${file("./id_rsa_outscale")}"
    agent = true
  }

  provisioner "file" {
    source      = "scripts/install_salt.sh"
    destination = "/tmp/install_salt.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo chmod +x /tmp/install_salt.sh",
      "sudo /tmp/install_salt.sh master",
      "sudo /tmp/install_salt.sh minion",
    ]
  }

}

resource "null_resource" "configure_lb" {
    triggers {
        instance = "${osc_instance.cloud-media-lb.id}"
    }
  connection {
    host        = "${osc_instance.cloud-media-lb.public_ip}"
    user        = "outscale"
    timeout     = "60s"
    private_key = "${file("./id_rsa_outscale")}"
    agent = true
  }

  provisioner "file" {
    source      = "scripts/install_salt.sh"
    destination = "/tmp/install_salt.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo chmod +x /tmp/install_salt.sh",
      "sudo /tmp/install_salt.sh minion",
    ]
  }

}

resource "null_resource" "configure_plex" {
    triggers {
        instance = "${osc_instance.cloud-media-lb.id}"
    }
  connection {
    bastion_host = "${osc_instance.cloud-media-adm.public_ip}"
    host        = "${osc_instance.cloud-media-plex.private_ip}"
    user        = "outscale"
    timeout     = "60s"
    private_key = "${file("./id_rsa_outscale")}"
    agent = true
  }

  provisioner "file" {
    source      = "scripts/install_salt.sh"
    destination = "/tmp/install_salt.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo chmod +x /tmp/install_salt.sh",
      "sudo /tmp/install_salt.sh minion",
    ]
  }

}
