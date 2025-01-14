terraform {
    required_version = ">=1.1.0"
    required_providers {
        intersight = {
            source = "CiscoDevNet/intersight"
            version = ">=1.0.20"
        }
    }
}

provider "intersight" {
    apikey        = var.intersight_key
    secretkey     = var.intersight_secret
    endpoint      = var.endpoint
}

data "intersight_organization_organization" "buffalo_dc" {
    name = "buffalo_dc"
}
# print default org moid
output "org_moid" {
    value = data.intersight_organization_organization.buffalo_dc.moid
}

module "intersight_policy_bundle" {
  source = "github.com/eminchen/tf-intersight-policy-bundle"

  # external sources
  organization    = data.intersight_organization_organization.buffalo_dc.id

  # every policy created will have this prefix in its name
  policy_prefix = "pod1"
#  description   = "Built by Terraform"

  # Fabric Interconnect 6454 config specifics
  server_ports_6454 = [17, 18, 19, 20, 21, 22, 23, 24, 25, 26]
  port_channel_6454 = [9, 10]
  uplink_vlans_6454 = {
    "vlan-1" : 1,
    "vlan-10" : 10
  }

  fc_port_count_6454 = 4

  imc_access_vlan    = 10
  imc_admin_password = "Cisco12#45"

  ntp_servers = ["ca.pool.ntp.org"]

  dns_preferred = "64.102.6.247"
#  dns_alternate = "172.22.16.253"

  ntp_timezone = "America/Toronto"

  # starting values for wwnn, wwpn-a/b and mac pools (size 255)
  wwnn-block   = "20:00:00:CA:FE:00:00:01"
  wwpn-a-block = "20:00:00:CA:FE:0A:00:01"
  wwpn-b-block = "20:00:00:CA:FE:0B:00:01"
  mac-block    = "00:CA:FE:00:00:01"

 tags = [
   { "key" : "Project", "value" : "Alpha" },
   { "key" : "Orchestrator", "value" : "Terraform" }
 ]
}
