terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.19.0"
    }
  }
}

provider "google" {
  project = "terraform-project-411319"
  region = "us-west1"
  zone = "us-west1-b"
  credentials = file("/secret/secret-key.json")
}

resource "google_compute_instance" "kubernetes" {
  name = "kubernetes"
  zone = "us-west1-b"
  machine_type = "e2-medium"
  allow_stopping_for_update = false
  boot_disk {
   initialize_params {
     image = "ubuntu-os-cloud/ubuntu-2004-lts"
   }
 }
 network_interface {
   network = google_compute_network.my-network.name
   subnetwork = google_compute_subnetwork.my-subnet.name
   access_config {
     
   }
}
  metadata = {
    ssh-keys = "diadji402:${file(var.ssh_public_key_path)}"
  }

  provisioner "file" {
    source = "/script"
    destination = "/home/diadji402/"
    connection {
      type = "ssh"
      user = "diadji402"
      private_key = file("${var.ssh_private_key_path}")
      host = self.network_interface[0].access_config[0].nat_ip
    }
  }
  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /home/diadji402/docker.sh",
      "sudo chmod +x /home/diadji402/minikube.sh",
      "/home/diadji402/docker.sh",
      "/home/diadji402/minikube.sh"
      ]
    connection {
      type = "ssh"
      user = "diadji402"
      private_key = file("${var.ssh_private_key_path}")
      host = self.network_interface[0].access_config[0].nat_ip
  }
}
}

resource "google_compute_instance" "jenkins" {
  name = "jenkins"
  zone = "us-west1-b"
  machine_type = "e2-medium"
  allow_stopping_for_update = false
  boot_disk {
   initialize_params {
     image = "ubuntu-os-cloud/ubuntu-2004-lts"
   }
 }
 network_interface {
   network = google_compute_network.my-network.name
   subnetwork = google_compute_subnetwork.my-subnet.name
   access_config {
     
   }
}
   metadata = {
    ssh-keys = "diadji402:${file(var.ssh_public_key_path)}"
  }
  provisioner "file" {
    source = "/script"
    destination = "/home/diadji402/"
  connection {
      type = "ssh"
      user = "diadji402"
      private_key = file("${var.ssh_private_key_path}")
      host = self.network_interface[0].access_config[0].nat_ip
    }
  }
  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /home/diadji402/jenkins.sh",
      "sudo chmod +x /home/diadji402/docker.sh",
      "sudo chmod +x /home/diadji402/ansible.sh",
      "/home/diadji402/jenkins.sh",
      "/home/diadji402/docker.sh",
      "/home/diadji402/ansible.sh"
      ]
    connection {
      type = "ssh"
      user = "diadji402"
      private_key = file("${var.ssh_private_key_path}")
      host = self.network_interface[0].access_config[0].nat_ip
  }
}
}


resource "google_compute_network" "my-network" {
  name = "toum-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "my-subnet" {
  name = "toum-subnet"
  network = google_compute_network.my-network.self_link
  ip_cidr_range = "10.2.0.0/24"
  region = "us-west1"

}

resource "google_compute_firewall" "my-firewall" {
  name = "firewal-rule"
  network = google_compute_network.my-network.name
  allow {
    protocol = "tcp"
    ports = ["22","80","8080"]
  }
  allow {
    protocol = "icmp"
  }
  source_ranges = ["0.0.0.0/0"]
}
