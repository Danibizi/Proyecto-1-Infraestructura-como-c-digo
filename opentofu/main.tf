##############################################
# web — Debian
##############################################

# Clon ligero sobre la imagen base: solo almacena los cambios diferenciales
resource "libvirt_volume" "web-disk" {
  name             = "web.qcow2"
  pool             = var.libvirt_pool_name
  base_volume_name = var.base_image_debian
  base_volume_pool = var.libvirt_pool_name
  format           = "qcow2"
}

# ISO cloud-init con la configuración inicial de la máquina
resource "libvirt_cloudinit_disk" "web-cloudinit" {
  name           = "web-cloudinit.iso"
  pool           = var.libvirt_pool_name
  user_data      = file("${path.module}/../cloud-init/user-data-web.yaml")
  network_config = file("${path.module}/../cloud-init/network-config-web.yaml")
}

# Definición del dominio (máquina virtual)
resource "libvirt_domain" "web" {
  name   = "web"
  memory = var.memory_mb
  vcpu   = 1

  # Red 1: NAT con DHCP
  network_interface {
    network_id     = libvirt_network.red-nat.id
    mac            = "52:54:00:aa:00:01"
    wait_for_lease = true
  }

  # Red 2: datos (IP estática 192.168.100.10 por cloud-init)
  network_interface {
    network_id = libvirt_network.red-datos.id
    mac        = "52:54:00:aa:00:02"
  }

  disk { volume_id = libvirt_volume.web-disk.id }
  cloudinit = libvirt_cloudinit_disk.web-cloudinit.id

  # Consola serie: permite entrar con "virsh console" aunque falle la red
  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }
}

##############################################
# bd — Ubuntu
##############################################

resource "libvirt_volume" "bd-disk" {
  name             = "bd.qcow2"
  pool             = var.libvirt_pool_name
  base_volume_name = var.base_image_ubuntu
  base_volume_pool = var.libvirt_pool_name
  format           = "qcow2"
}

resource "libvirt_cloudinit_disk" "bd-cloudinit" {
  name           = "bd-cloudinit.iso"
  pool           = var.libvirt_pool_name
  user_data      = file("${path.module}/../cloud-init/user-data-bd.yaml")
  network_config = file("${path.module}/../cloud-init/network-config-bd.yaml")
}

resource "libvirt_domain" "bd" {
  name   = "bd"
  memory = var.memory_mb
  vcpu   = 1

  # Red 1: NAT con DHCP
  network_interface {
    network_id     = libvirt_network.red-nat.id
    wait_for_lease = true
  }

  # Red 2: datos (IP estática 192.168.100.11 por cloud-init)
  network_interface {
    network_id = libvirt_network.red-datos.id
  }

  disk { volume_id = libvirt_volume.bd-disk.id }
  cloudinit = libvirt_cloudinit_disk.bd-cloudinit.id

  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }
}
