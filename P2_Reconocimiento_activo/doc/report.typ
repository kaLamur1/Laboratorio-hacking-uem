#set document(title: "Práctica 2: Reconocimiento Activo", author: "Aarón")
#set page(numbering: "1")
#show raw: it => block(
  fill: luma(230),
  inset: 10pt,
  radius: 4pt,
  text(font: "DejaVu Sans Mono", it)
)

#align(center)[
  = Práctica 2: Reconocimiento Activo
  *Aarón Peñafiel Pacheco*
  *Universidad Europea de Madrid*
  *Abril 2026*
]

#pagebreak()

#heading(outlined: false)[Resumen]

Esta práctica tiene como objetivo aplicar técnicas de reconocimiento activo sobre entornos simulados con Docker. Se divide en dos partes: primero, la implementación de una función en Python con Scapy para descubrir hosts activos en una red mediante tres protocolos diferentes; y segundo, el análisis del comportamiento por defecto de nmap para el descubrimiento de puertos y su estado.

A diferencia del reconocimiento pasivo, estas técnicas generan tráfico directo hacia los objetivos, por lo que se realizan exclusivamente sobre entornos controlados.

#pagebreak()

#outline()

#pagebreak()

= Introducción

El reconocimiento activo es una fase fundamental en cualquier auditoría de seguridad. Consiste en interactuar directamente con los sistemas objetivo para obtener información sobre su estado, servicios expuestos y configuración de red.

En esta práctica se trabaja sobre dos herramientas complementarias: _Scapy_, una librería Python que permite construir y enviar paquetes de red a medida, y _nmap_, la herramienta de escaneo de redes más utilizada en el sector.

El entorno de pruebas consiste en tres contenedores Docker que exponen servicios reales: un servidor web nginx (HTTP), un servidor FTP y un servidor SSH.

#pagebreak()

= Desarrollo

== Parte 1: Descubrimiento de hosts con Scapy

=== Infraestructura

Para esta parte se utiliza la red local de la máquina virtual con IP `192.168.122.1` como host activo y `192.168.122.200` como IP inactiva para contrastar resultados.

=== Función `craft_discovery_pkts`

La función recibe los siguientes argumentos:

/ `protocols`: Lista o string con los protocolos a usar (`"UDP"`, `"TCP"`, `"ICMP"`). Obligatorio.
/ `ips`: IP o rango destino en formato string. Obligatorio.
/ `pkt_count`: Diccionario opcional con el número de paquetes por protocolo. Por defecto 1.
/ `port`: Puerto para TCP y UDP. Por defecto 80.

Los tres protocolos utilizados funcionan de la siguiente manera:

/ UDP: Se envía un paquete al puerto destino. Si el puerto está cerrado el host responde con ICMP "Port Unreachable", confirmando que está activo.
/ TCP ACK: Se envía un paquete ACK sin conexión previa. El host responde con RST confirmando que está activo.
/ ICMP Timestamp: Se pregunta al host su hora actual. Útil cuando los firewalls bloquean el ping normal (ICMP Echo).

```python
from scapy.all import *

def craft_discovery_pkts(protocols, ips, pkt_count=None, port=80):
    packages = [] # Lista de paquetes a enviar
    for protocol in protocols:
        # Si no se pasa pkt_count se construye 1 paquete por protocolo
        if pkt_count == None:
            n = 1
        else:
            n = pkt_count[protocol]

        if protocol == "UDP":
            for i in range(n):
                package = IP(dst=ips) / UDP(dport=port)
                packages.append(package)

        elif protocol == "TCP":
            for i in range(n):
                # flags="A" indica ACK
                package = IP(dst=ips) / TCP(dport=port, flags="A")
                packages.append(package)

        elif protocol == "ICMP":
            for i in range(n):
                # type=13 es ICMP Timestamp Request
                package = IP(dst=ips) / ICMP(type=13)
                packages.append(package)

    return packages
```

=== Ejemplo de uso

```python
# Host activo
packages = craft_discovery_pkts(["UDP", "TCP", "ICMP"], "192.168.122.1")
answered, unanswered = sr(packages, timeout=2, verbose=0)

for sent, received in answered:
    if sent.haslayer(UDP):
        proto = "UDP"
    elif sent.haslayer(TCP):
        proto = "TCP"
    elif sent.haslayer(ICMP):
        proto = "ICMP"
    print(f"{received[IP].src} -> {proto} ha respondido")
```

== Parte 2: Comportamiento por defecto de nmap

=== Infraestructura

Para esta parte se levantan tres contenedores Docker con la siguiente configuración:

#table(
  columns: (auto, auto, auto),
  [*Contenedor*], [*Servicio*], [*IP*],
  [http-container], [nginx (HTTP)], [172.19.0.4],
  [ftp-container], [FTP], [172.19.0.3],
  [ssh-container], [SSH], [172.19.0.2],
)

#image("images/Docker_compose.png")

=== Estado de un puerto

Un puerto puede encontrarse en tres estados posibles:

/ Abierto: Hay un servicio escuchando. El host responde con SYN-ACK al SYN de nmap.
/ Cerrado: No hay servicio. El host responde con RST-ACK al SYN de nmap.
/ Filtrado: Un firewall bloquea el tráfico. No hay respuesta alguna.

#table(
  columns: (auto, auto, auto),
  [*Estado*], [*Estímulo*], [*Respuesta*],
  [Abierto], [SYN], [SYN-ACK],
  [Cerrado], [SYN], [RST-ACK],
  [Filtrado], [SYN], [Sin respuesta],
)

=== Comportamiento por defecto de nmap

Cuando se ejecuta nmap sin opciones adicionales realiza un *SYN scan* (también llamado half-open scan o stealth scan) sobre los *1000 puertos más comunes*. Este tipo de escaneo:

- Envía un paquete TCP SYN a cada puerto
- Si recibe SYN-ACK responde con RST para no completar el handshake
- Nunca establece una conexión completa, lo que lo hace más sigiloso

Los puertos se escanean en *orden aleatorio* para dificultar su detección por sistemas IDS/IPS.

#pagebreak()

= Resultados

== Parte 1: Descubrimiento de hosts

=== Host activo

La ejecución del script contra `192.168.122.1` devuelve respuesta para los tres protocolos:

#image("images/image.png")

La captura de Wireshark confirma el tráfico generado por los tres protocolos:

#image("images/image2.png")

=== Host inactivo

Al ejecutar contra `192.168.122.200` no se obtiene ninguna respuesta. Scapy muestra warnings de MAC no encontrada ya que el host no existe en la red.

== Parte 2: nmap

=== Resultados del escaneo

#image("images/resultado_nmap.png")

#table(
  columns: (auto, auto, auto),
  [*Host*], [*Puerto*], [*Servicio*],
  [172.19.0.4], [80/tcp], [HTTP],
  [172.19.0.3], [21/tcp], [FTP],
  [172.19.0.2], [22/tcp], [SSH],
)

=== Puerto abierto (80/tcp)

La captura de Wireshark muestra el intercambio SYN → SYN-ACK → RST característico del SYN scan:

#image("images/comprobación_puerto_80.png")

=== Puerto cerrado (443/tcp)

Al escanear el puerto 443 de nginx, el host responde con RST-ACK confirmando que está cerrado:

#image("images/respuesta_puerto_443.png")

=== Puerto filtrado

Al escanear una IP inexistente (`172.19.0.100`), nmap solo genera tráfico ARP sin respuesta. No llega a escanear puertos porque no puede confirmar que el host esté activo:

#image("images/Respuestas_no_funcional.png")

=== Evidencia del tráfico completo

#image("images/muestras_nmap.png")

#pagebreak()

= Conclusiones

Esta práctica ha demostrado el funcionamiento de dos aproximaciones complementarias al reconocimiento activo.

En la parte 1, la función `craft_discovery_pkts` permite construir paquetes personalizados con tres protocolos distintos para detectar hosts activos. Cada protocolo tiene ventajas diferentes — TCP ACK es más sigiloso, ICMP Timestamp puede evadir firewalls que bloquean el ping normal, y UDP permite detectar hosts que no responden a TCP.

En la parte 2, se ha comprobado que nmap realiza por defecto un SYN scan sobre los 1000 puertos más comunes, en orden aleatorio y sin completar el handshake TCP. Las respuestas permiten clasificar cada puerto como abierto, cerrado o filtrado según el tipo de paquete recibido.

#pagebreak()

#bibliography("bibliography.bib")