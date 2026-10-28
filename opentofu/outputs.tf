output "ips" {
  description = "IP de las máquinas en la red NAT"
  value = {
    web1 = libvirt_domain.web.network_interface[0].addresses[0]
    web2 = "192.168.100.10" #Estatica
    bd1 = libvirt_domain.bd.network_interface[0].addresses[0]
    bd2 = "192.168.100.11" #Estatica
  }
}
