#set document(title: "Práctica 1: Reconocimiento Pasivo", author: "Aarón")
#set page(numbering: "1")
#align(center)[
  = Práctica 1: Recogida de Información Pasiva
  *Aarón Peñafiel Pacheco*
  *Universidad Europea de Madrid*
  *Marzo 2026*
]

#pagebreak()

#heading(outlined: false)[Resumen]

Esta práctica es para poner en uso lo aprendido en las primeras unidades de la asignatura.

Para ello debíamos elegir una empresa del IBEX35, la que yo he elegido es Banco Santander. 
Una empresa con bastante información pública debido a ser una de las entidades bancarias más importantes del país.

Sobre esa empresa lo que haremos es una recopilación de datos pasiva. Centrándonos en dos cosas principalmente.
Una investigación de los registros DNS y luego una auditoría para poder tener un perfíl de su presencia digital.
#pagebreak()

#outline()

#pagebreak()

= Investigación de Registros DNS

Lo primero que hay que tener es: ¿qué es una DNS?
A alto nivel, DNS es un servicio el cual traduce las direcciones IP a dominios.
Esto quiere decir que en vez de tener que escribir 8.8.8.8, puedo escribir google.com y me lleva al mismo sitio.

Veamos el tema de los registros:
/ A: Traductor de dominios a direcciones IPv4
  Básicamente es lo que nos permite que al nosotros escribir google.com esto se traduzca a 8.8.8.8. #cite(<redeszone>)

/ AAAA: Traducción de dominio a direcciones IPv6
  El nombre se debe a como funciona, IPv4 son 32 bits y es una A, com IPv6 son 128 bits por eso son 4 A, $4 times 32$.

/ MX: Intercambio de correo
  _"Este dirige los mensajes de correo electrónico de acuerdo con el Protocolo para transferencia simple de coreo."_ #cite(<cloudfare>)
  Esto lo que le permite es saber a que servidor se deben enviar correos a direcciones que tengan que ver con la Entidad.

/ TXT: Un texto
  Este es tal cual un texto el cual permite a los administradores insertar texto en los registros DNS, puede usarse para dejar información del dominio. #cite(<redeszone>)

/ CNAME: Registros de alias.
  Esto nos permite añadir alias a nuestro dominio principal, de esta manera cuando se usa esos alias se interpretarán como si fuesen el dominio tal cual. #cite(<cloudfare_CNAME>)

/ NS: Nombre del servidor
  Este es el servidor de nombres autorizados para el dominio. #cite(<redeszone>)

/ SOA: Comienzo de autoridad
  Se guarda información esencial:
  - fecha de la última actualización del dominio
  - otros cambios
  - actividades

/ PTR: Dominio (inverso)
  Este traduce al reves, lo que hace es traducir la IP a un Dominio.
  _"(...) la sintaxis de DNS es la responsable del mapeo de una dirección IPv4 para el CNAME en el alojamiento."_ #cite(<redeszone>)

La principal diferencia entre la recogida pasiva y activa, ¿cuál es? El tráfico.

Las técnicas pasivas no generan tráfico hacia la entidad directamente de nosotros, si no que usa intermediarios, como herramientas web públicas.
Esto es importante ya que d eesa manera la entidad puede ver quien le ha generado dicho tráfico, pero no quien lo ha solicitado. 
Es decir. no sabe quienes somos nosotros, los que realmente hemos pedido la información.

Esto lo diferencia al reconocimiento activo, en este las consultas SÍ las hace nuestro dispositivo directamente hacia el objetivo. Esto le permite detectar, registrar e incluso bloquearnos.

Por ejemplo al usar webs como #link("https://who.is/")[WHOIS] o #link("https://dnschecker.org/")[DNSchecker] son herramientas de recolección pasivas, mientras que herramientas como dig o nslookup ya son herramientas activas.

#pagebreak()

= Auditoria OSINT
En este caso se le hará a la empresa Banco Santander.
Este es un servicio de banca a nivel nacional e internacional. Presente, principalmente, en España y varios países de Sudamerica y Centroamerica.

Su clientela va desde particulares con pequeñas y grandes fortunas (banca privada) y autónomos , hasta empresas pequeñas y grandes, instituciones e incluso universidades.

Prestando una gran variedad de servicios dependiendo del pais y de quien los solicite.
/ Particulares:
  - OpenBank
  - Santander
  - Santander Customer Fiance
  - Santander universidades

/ Empresas:
  - Bancasar
  - Santander Advance
  - Santander Factoring & Confirming
  - Santander Trade

/ Instituciones:
  - Santander Instituciones financieras
  - Santander Instituciones Privadas
  - Santander Instituciones Públicas
  
/ Corporaciones:
  -  Santander Factoring & Confirming

/ Banca Privada:
  - Banca online 
  - Santander Private Banking

/ universidades:
  - Santander

Para más información de cada servicio:#cite(<Santander_servicios>)


En cuanto a sus proveedores, no se encuentra demasiada información detallada, pero los más importantes son los siguientes:
/ Microsoft: servicios nube
  Esta empresa es el principal asociado para los servicios nubes, para facilitar la transformación del banco al sector digital.
  Esta alianza se firmo en 2019 #cite(<Microsoft_Santander>)

/ Google: para la creación de la herramienta Dual Run
  Una herramienta la cual ayudaría a otras empresas e industrias al cambio a la nube.#cite(<Google_Santander>)

/ AWS: Catalyst
  Junto a AWS lanzaron esta infraestructura en el 2018 para los inicios de la banca digital.#cite(<AWS_Santander>)

== Presencia digital
Siguiendo con lo pedido en la práctica vamos a investigar primero los 
Servicios y Tecnologías expuestas.
Para eso lo primero que vamos a usar es la herramienta llamada BuiltWith.#cite(<BuiltWith>)

Al iniciar la búsqueda de la pagina web "santander.com" obtenemos una gran cantidad de datos, pero los más importantes son los siguientes.

#table(
  columns: (auto, auto),
  [*Función*], [*Tecnologia*],
  [Servidor web], [Apache],
  [Tecnologia del backend], [Java EE],
  [Correo corporativo], [Microsoft Exchange Online/Office 365],
  [Seguridad de correo], [Cisco IronPort Cloud],
  [Política de seguridad de correo], [ SPF y DMARC Reject],
  [Seguridad web], [SSL por defecto + HSTS],
  [Certificados SSL],[GlobalSign],
  [Gestor de contenido web],[Adobe Experience Manager],
  [Libreria de Javascript frontend],[jQuery 3.5.1],
)

En esta página también obtenemo un poco de información sobre la infraestructura y algunos otros proveedores:
#table(
  columns: (auto, auto),
  [*Función*],[*Tecnologia*],
  [CDN y DNS principal],[Akamai Edge + DNS],
  [CDN y seguridad],[Cloudflare + Incapsula],
  [CDN secundario],[Fastly],
  [DNS secundario], [Microsoft Azure DNS],
  [Protección de bots],[Imperva],
  [Almacenamiento en nube],[Amazon S3],
  [Registro del dominio],[Tucows],
)

Estos son los más destacables. 

Pasando a otra cosa buscando los registros dns, usé la herramienta Whois#cite(<whois_santander>) 
Con la herramienta obtuve confirmación de alguna de la información antes mencionada. Por ejemplo:

Se confirma el registrador como Tucows Domain Inc. y algunas fechas importante:
- Fecha de registro en el 23 de abril de 1998
- Fecha de expiración en el 22 de abril de 2035

los nameservers son de Akamai, confirmando que es el que gestiona el DNS.

Comprobando el estado veo que está protegido contra transferencia o modificación no autorizadas del dominio.
"clientTransferProhibited" y "clientUpdateProhibited"

Otros datos interesantes son el contacto del registrante, que aparece como Cantabria, ubicación al tener en cuenta que que Banco santander, obviamente es Cantabria. 
#image("/assets/image.png")

Pero algo muy importante a resaltar dentro del raw data del RDAP es lo siguiente:
#image("/assets/image-1.png")

Es decir, no hay DNSSEC una información importante a tener en cuenta para un posible ataque.

Ya dirigiendome directamente a los DNS register vemos lo siguiente:
#image("/assets/image-2.png")

De todo esto lo que realmente nos interesa son:
- Las ips son de Akamai, confirmando el uso de su CDN.
- El registro MX nos confirma el uso tanto de Cisco IronPort.
  Esto debido a que la infraestructura iphmx.com es propiedad de Cisco
- Registro SOA:
  Obtenemos el servidor DNS primario, y nos damos cuenta que es propio.
  "dns01.santandergroup.net" y el email del administrador DNS mostrando que usan internamente el dominio "gruposantander.com"

- y al apuntar www.santander.com a gm9f8cj.impervadns.net confirmamos al seguridad web por parte de Imperva.

Ya hemos sacado la información de la ip del servidor en el que se encuentra la web. 
Como ya había comentado esta en 
#pagebreak()

= Resultados

#pagebreak()

= Conclusiones 

#pagebreak()

#bibliography("bibliography.bib")