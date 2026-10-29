# Guía Rápida: OpenTofu Apply y Conexión SSH

Este documento explica cómo aplicar la infraestructura con OpenTofu y utilizar las variables de salida (*outputs*) para conectarte por SSH directamente a tus servidores.

## Paso 1: Inicializar y Aplicar

1. Entra al directorio donde están tus archivos de configuración (`/opentofu`).
2. Aplica los cambios ejecutando el comando:

```bash
tofu apply
```

3. Revisa el plan que se muestra en pantalla y escribe `yes` cuando te pida confirmación.

## Paso 2: Obtener la IP desde el Output

Para poder conectar por SSH automáticamente,usaremos el output:

```hcl
Outputs:

ips = {
  "bd1" = "192.168.10.196"
  "bd2" = "192.168.100.11"
  "web1" = "192.168.10.253"
  "web2" = "192.168.100.10"
}
```

## Paso 3: Conectar por SSH

Ejecuta el siguiente comando en tu terminal (reemplaza `ubuntu` por tu usuario e `id_rsa` por tu clave privada si es necesario):

```bash
ssh ubuntu@IP
ssh debian@IP
```

# !Aviso!

Se debera tener tu clave publica configurada en `cloud-init/user-data-web.yaml` al igual que con bd.


## Paso 4: Aplicamos el playbook

Ejecutamos el playbook con `ansible-play ansible/site.yaml`

Y una vez ejecutado,tendremos el servidor web corriendo junto al bd,pudiendo hacer publicaciones.

