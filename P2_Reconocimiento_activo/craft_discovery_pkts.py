from scapy.all import *
## La función crea los paquetes que se lanzaran.
def craft_discovery_pkts(protocols, ips, pkt_count=None, port=80):
    packages = [] # lista de los paquetes a enviar
    for protocol in protocols: #los protocolos se almacenan en la lista protocols 
        if pkt_count == None:
           n = 1
        else:
            n = pkt_count[protocol]
        # al se opcional, lo que hago es que si no hay nada oslo se cree 1 paquete
        # si no se muestra el número que haya. 
        if protocol == "UDP":
            for i in range(n):
                package = IP(dst = ips) / UDP(dport = port)
                packages.append(package)

        elif protocol == "TCP":
            for i in range(n):
                package = IP(dst = ips) / TCP(dport = port, flags="A")
                packages.append(package)

        elif protocol == "ICMP":
            for i in range(n):
                package = IP(dst = ips) / ICMP(type=13)
                packages.append(package)
    return packages
# aplicación de la funcion para el IP
packages = craft_discovery_pkts(["UDP", "TCP", "ICMP"], "192.168.122.1")

answered, unanswered = sr(packages, timeout=2, verbose=0)
# creación de las respuestas. y el mensaje que aparece.
for sent, received in answered:
    if sent.haslayer(UDP):
        proto = "UDP"
    elif sent.haslayer(TCP):
        proto = "TCP"
    elif sent.haslayer(ICMP):
        proto = "ICMP"
    
    print(f"{received[IP].src} -> {proto} ha respondido")