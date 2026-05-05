terraform {
  required_providers {
    upcloud = {
      source  = "UpCloudLtd/upcloud"
      version = "~> 5.23"
    }
  }
}

variable "prefix" {
  type    = string
  default = "ansible"
}

variable "zone" {
  type    = string
  default = "fi-hel1"
}

locals {
  publickey_filename = one(fileset(pathexpand("~/.ssh/"), "*.pub"))
  publickey          = file("~/.ssh/${local.publickey_filename}")
  login_user         = "admin"
}

resource "upcloud_server" "webservers" {
  count    = 1
  hostname = "${var.prefix}server-${count.index}"
  title    = "${var.prefix}server-${count.index}"
  zone     = var.zone
  plan     = "1xCPU-1GB"

  metadata = true

  login {
    user = local.login_user
    keys = [
      local.publickey,
    ]
  }
  template {
    storage = "Debian GNU/Linux 13 (Trixie)"
    size    = 25
    title   = "${var.prefix}storage-${count.index}"
  }

  # In production, the public interface should be (in most cases) omitted:
  # - Use a jump-host in the same network to control the application nodes.
  # - Use a NAT gateway to provide internet access for the application nodes.
  network_interface {
    type = "public"
  }

  network_interface {
    type = "utility"
  }
}

resource "upcloud_server_group" "webservers" {
  title = "${var.prefix}servergroup"
  anti_affinity_policy = "yes"
  members = upcloud_server.webservers[*].id
}

output "server_public_ips" {
  description = "Public IP addresses of the deployed webservers"
  value       = [for s in upcloud_server.webservers : "${local.login_user}@${s.network_interface[0].ip_address}"]
}
