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

Está práctica es para poner en uso lo aprendido en las primera unidades de la asignatura.

Para ello debiamos elegir una empresa del IBEX35, la que yo he elegido es Banco Santander. 
Una empresa con bastante información pública debido a ser una de las entidades bnacarias más importantes del país.

Sobre esa empresa lo que haremos es una recopilación de datos pasiva. Centrándonos en dos cosas principalmente.
Una investigación de los registros DNS y luego una auditoria para poder tener un perfíl de su presencia digital.
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

/ AAAA: Traducción de dominioa a direccions IPv6
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

Esto lo diferencia al reconocimiento activo, en este las consultas SÍ las hace nuestro dispositivo directamene hacia el objetivo. Esto le permite detectar, regsitrar e incluso bloquearnos.

#pagebreak()

= Auditoria OSINT

#pagebreak()

= Resultados

#pagebreak()

= Conclusiones 

#pagebreak()

#bibliography("bibliography.bib")