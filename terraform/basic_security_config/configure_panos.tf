/* Ethernet Interfaces ---------------------------------------------------- */

resource "panos_ethernet_interface" "wan" {
  name                      = var.eth1_name
  mode                      = var.eth1_mode
  vsys                      = var.eth1_vsys
  enable_dhcp               = true
  create_dhcp_default_route = true
}

resource "panos_ethernet_interface" "dmz" {
  name       = var.eth2_name
  mode       = var.eth2_mode
  vsys       = var.eth2_vsys
  static_ips = var.eth2_ips
}

/* Virtual Routers -------------------------------------------------------- */

resource "panos_virtual_router" "default_vr" {
  name       = var.vr_name
  interfaces = [panos_ethernet_interface.wan.name, panos_ethernet_interface.dmz.name]
  depends_on = [panos_ethernet_interface.wan, panos_ethernet_interface.dmz]
}

/* Security Zones --------------------------------------------------------- */

resource "panos_zone" "wan" {
  name       = var.wan_zone_name
  mode       = var.wan_zone_mode
  interfaces = [panos_ethernet_interface.wan.name]
}

resource "panos_zone" "dmz" {
  name       = var.dmz_zone_name
  mode       = var.dmz_zone_mode
  interfaces = [panos_ethernet_interface.dmz.name]
}

/* Service Objects -------------------------------------------------------- */

resource "panos_service_object" "service_tcp_221" {
  name             = var.service_tcp_221_name
  vsys             = var.service_tcp_221_vsys
  protocol         = var.service_tcp_221_protocol
  description      = var.service_tcp_221_description
  destination_port = var.service_tcp_221_destination_port
}

resource "panos_service_object" "service_tcp_222" {
  name             = var.service_tcp_222_name
  vsys             = var.service_tcp_222_vsys
  protocol         = var.service_tcp_222_protocol
  description      = var.service_tcp_222_description
  destination_port = var.service_tcp_222_destination_port
}

resource "panos_service_object" "http-81" {
  name             = var.service_tcp_81_name
  vsys             = var.service_tcp_81_vsys
  protocol         = var.service_tcp_81_protocol
  description      = var.service_tcp_81_description
  destination_port = var.service_tcp_81_destination_port
}

/* NAT Policies ----------------------------------------------------------- */

resource "panos_nat_rule_group" "test" {
  rule {
    name          = var.nat_dmz_wan_out_name
    audit_comment = var.nat_dmz_wan_out_audit
    original_packet {
      source_zones          = [panos_zone.dmz.name]
      destination_zone      = panos_zone.wan.name
      destination_interface = panos_ethernet_interface.wan.name
      source_addresses      = [var.nat_dmz_wan_out_src_addr]
      destination_addresses = [var.nat_dmz_wan_out_dst_addr]
    }
    translated_packet {
      source {
        dynamic_ip_and_port {
          interface_address {
            interface = panos_ethernet_interface.wan.name
          }
        }
      }
      destination {}
    }
  }
}

/* Security Policies ------------------------------------------------------ */

resource "panos_security_policy" "DMZ-to-WAN-allow" {
  rule {
    name                  = var.policy_dmz_wan_out_name
    audit_comment         = var.policy_dmz_wan_out_audit_comment
    source_zones          = [panos_zone.dmz.name]
    source_addresses      = [var.policy_dmz_wan_out_source_addresses]
    source_users          = [var.policy_dmz_wan_out_source_users]
    destination_zones     = [panos_zone.wan.name]
    destination_addresses = [var.policy_dmz_wan_out_destination_addresses]
    applications          = [var.policy_dmz_wan_out_applications]
    services              = [var.policy_dmz_wan_out_services]
    categories            = [var.policy_dmz_wan_out_categories]
    action                = var.policy_dmz_wan_out_action
  }

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [
    panos_zone.dmz,
    panos_zone.wan
  ]
}
