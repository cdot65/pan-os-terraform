/* Firewall Connectivity -------------------------------------------------- */

variable "fw_ip" {
  description = "Firewall IP address"
}
variable "username" {
  description = "username to log into the firewall"
}
variable "password" {
  description = "password of user"
}

/* Ethernet Interfaces ---------------------------------------------------- */

variable "eth1_name" {
  description = "Name of our Ethernet 1/1 interface"
}

variable "eth1_mode" {
  description = "Interface mode"
}

variable "eth1_vsys" {
  description = "eth1 vsys assignment"
}

variable "eth1_dhcp" {
  description = "Enable interface for DHCP client"
}

variable "eth1_default_route" {
  description = "Accept default route"
}

variable "eth2_name" {
  description = "Name of our Ethernet 1/2 interface"
}

variable "eth2_mode" {
  description = "Mode of our Ethernet 1/2 interface"
}

variable "eth2_vsys" {
  description = "eth2 vsys assignment"
}

variable "eth2_ips" {
  description = "Static IP assignment"
}

/* Virtual Routers -------------------------------------------------------- */
variable "vr_name" {
  description = "name of our virtual router"
}

/* Security Zones --------------------------------------------------------- */

variable "wan_zone_name" {
  description = "name of our WAN zone"
}

variable "wan_zone_mode" {
  description = "WAN zone mode"
}

variable "dmz_zone_name" {
  description = "name of our DMZ zone"
}

variable "dmz_zone_mode" {
  description = "DMZ zone mode"
}

/* Service Objects -------------------------------------------------------- */

variable "service_tcp_221_name" {
  description = ""
}
variable "service_tcp_221_vsys" {
  description = ""
}
variable "service_tcp_221_protocol" {
  description = ""
}
variable "service_tcp_221_description" {
  description = ""
}
variable "service_tcp_221_destination_port" {
  description = ""
}

variable "service_tcp_222_name" {
  description = ""
}
variable "service_tcp_222_vsys" {
  description = ""
}
variable "service_tcp_222_protocol" {
  description = ""
}
variable "service_tcp_222_description" {
  description = ""
}
variable "service_tcp_222_destination_port" {
  description = ""
}

variable "service_tcp_81_name" {
  description = ""
}
variable "service_tcp_81_vsys" {
  description = ""
}
variable "service_tcp_81_protocol" {
  description = ""
}
variable "service_tcp_81_description" {
  description = ""
}
variable "service_tcp_81_destination_port" {
  description = ""
}

/* NAT Policies ----------------------------------------------------------- */

variable "nat_dmz_wan_out_name" {
  description = ""
}
variable "nat_dmz_wan_out_audit" {
  description = ""
}
variable "nat_dmz_wan_out_src_addr" {
  description = ""
}
variable "nat_dmz_wan_out_dst_addr" {
  description = ""
}

/* Security Policies ------------------------------------------------------ */

variable "policy_dmz_wan_out_name" {
  description = ""
}
variable "policy_dmz_wan_out_audit_comment" {
  description = ""
}
variable "policy_dmz_wan_out_source_addresses" {
  description = ""
}
variable "policy_dmz_wan_out_source_users" {
  description = ""
}
variable "policy_dmz_wan_out_destination_addresses" {
  description = ""
}
variable "policy_dmz_wan_out_applications" {
  description = ""
}
variable "policy_dmz_wan_out_services" {
  description = ""
}
variable "policy_dmz_wan_out_categories" {
  description = ""
}
variable "policy_dmz_wan_out_action" {
  description = ""
}
