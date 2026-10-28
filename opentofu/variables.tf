# Pool de almacenamiento donde se crean los volúmenes (disco y cloud-init)
variable "libvirt_pool_name" {
  type        = string
  description = "Nombre del pool de almacenamiento libvirt."
  default     = "default"
}

# Imagen base en formato qcow2 ya disponible en el pool
# Se usa como backing store para el clon ligero
variable "base_image_debian" {
  type        = string
  description = "Nombre de la imagen base Debian en el pool."
  default     = "debian13-base.qcow2"
}

variable "base_image_ubuntu" {
  type        = string
  description = "Nombre de la imagen base ubuntu en el pool."
  default     = "ubuntu2604-base.qcow2"
}

# Memoria RAM de cada máquina
variable "memory_mb" {
  type        = number
  description = "Memoria RAM de cada máquina virtual (MiB)."
  default     = 1024
}


# Rango de la red NAT (con DHCP: acceso desde el equipo y salida a internet)
variable "red_nat_cidr" {
  type        = string
  description = "Rango de la red NAT."
  default     = "192.168.10.0/24"
}
