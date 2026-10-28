# Red NAT con DHCP: acceso desde el equipo y salida a internet
resource "libvirt_network" "red-nat" {
  name      = "red-nat"
  mode      = "nat"
  domain    = "example.com"
  addresses = [var.red_nat_cidr]
  dhcp { enabled = true }
  dns { enabled = true }
  autostart = true
}

# Red de datos muy aislada (mode=none): enlace directo entre web y bd, IP estáticas
resource "libvirt_network" "red-datos" {
  name      = "red-datos"
  mode      = "none"
  autostart = true
}
