resource "null_resource" "configure_adm" {
    triggers {
        instance = "${osc_instance.cloud-media-adm.id}"
    }
  connection {
    host        = "${osc_eip.cloud-media-adm-eip.public_ip}"
    user        = "outscale"
    timeout     = "90s"
    private_key = "${file("./ssh-key/id_rsa_outscale")}"
    agent = true
  }

  provisioner "file" {
    source      = "scripts/install_salt.sh"
    destination = "/tmp/install_salt.sh"
  }

  provisioner "file" {
    source      = "ssh-key/cloudmedia_rsa"
    destination = "/tmp/id_rsa"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo mv /tmp/id_rsa /root/.ssh/ && sudo chmod 400 /root/.ssh/id_rsa && sudo chown root:root /root/.ssh/id_rsa",
      "sudo yum install epel-release -y",
      "sudo yum install htop vim tree git-core -y",
      "sudo ssh-keyscan github.com >> /tmp/known_hosts && sudo chown root:root /tmp/known_hosts && sudo mv /tmp/known_hosts /root/.ssh/known_hosts && sudo git clone git@github.com:mkay1905/salt-cloudmedia-repo.git /srv/salt-cloudmedia-repo && sudo git clone git@github.com:mkay1905/salt-cloudmedia-pillar.git /srv/salt-cloudmedia-pillar",
      "sudo chmod +x /tmp/install_salt.sh",
      "sudo /tmp/install_salt.sh master osc-eu-adm",
      "sudo /tmp/install_salt.sh minion osc-eu-adm",
    ]
  }

}

resource "null_resource" "configure_lb" {
    triggers {
        instance = "${osc_instance.cloud-media-lb.id}"
    }
  connection {
    host        = "${osc_eip.cloud-media-lb-eip.public_ip}"
    user        = "outscale"
    timeout     = "90s"
    private_key = "${file("./ssh-key/id_rsa_outscale")}"
    agent = true
  }

  provisioner "file" {
    source      = "scripts/install_salt.sh"
    destination = "/tmp/install_salt.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum install epel-release -y",
      "sudo yum install htop vim tree -y",
      "sudo chmod +x /tmp/install_salt.sh",
      "sudo /tmp/install_salt.sh minion osc-eu-lb",
    ]
  }

}

resource "null_resource" "configure_plex" {
    triggers {
        instance = "${osc_instance.cloud-media-lb.id}"
    }
  connection {
    bastion_host = "${osc_eip.cloud-media-adm-eip.public_ip}"
    host        = "${osc_instance.cloud-media-plex.private_ip}"
    user        = "outscale"
    timeout     = "90s"
    private_key = "${file("./ssh-key/id_rsa_outscale")}"
    agent = true
  }

  provisioner "file" {
    source      = "scripts/install_salt.sh"
    destination = "/tmp/install_salt.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum install epel-release -y",
      "sudo yum install htop vim tree -y",
      "sudo chmod +x /tmp/install_salt.sh",
      "sudo /tmp/install_salt.sh minion osc-eu-plex",
    ]
  }

}
