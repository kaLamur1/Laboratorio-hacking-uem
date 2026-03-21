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

Esta práctica tiene como objetivo aplicar técnicas de reconocimiento pasivo para obtener la huella digital de una empresa del IBEX35, en este caso Banco Santander.

A través de fuentes públicas y herramientas OSINT, se ha realizado una investigación en dos partes: primero un análisis teórico de los registros DNS y su papel en el reconocimiento pasivo, y después una auditoría completa de la presencia digital de Banco Santander, incluyendo su infraestructura tecnológica, presencia geográfica, activos expuestos y presencia en redes sociales.

En ningún momento se ha generado tráfico directo hacia los sistemas de la empresa, manteniéndose estrictamente dentro de los límites del reconocimiento pasivo.

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
  El nombre se debe a cómo funciona, IPv4 son 32 bits y es una A, como IPv6 son 128 bits por eso son 4 A, $4 times 32$.

/ MX: Intercambio de correo
  _"Este dirige los mensajes de correo electrónico de acuerdo con el Protocolo para transferencia simple de correo."_ #cite(<cloudfare>)
  Esto lo que le permite es saber a qué servidor se deben enviar correos a direcciones que tengan que ver con la entidad.

/ TXT: Un texto
  Este es tal cual un texto el cual permite a los administradores insertar texto en los registros DNS, puede usarse para dejar información del dominio. #cite(<redeszone>)

/ CNAME: Registros de alias.
  Esto nos permite añadir alias a nuestro dominio principal, de esta manera cuando se usan esos alias se interpretarán como si fuesen el dominio tal cual. #cite(<cloudfare_CNAME>)

/ NS: Nombre del servidor
  Este es el servidor de nombres autorizados para el dominio. #cite(<redeszone>)

/ SOA: Comienzo de autoridad
  Se guarda información esencial:
  - Fecha de la última actualización del dominio
  - Otros cambios
  - Actividades

/ PTR: Dominio (inverso)
  Este traduce al revés, lo que hace es traducir la IP a un dominio.
  _"(...) la sintaxis de DNS es la responsable del mapeo de una dirección IPv4 para el CNAME en el alojamiento."_ #cite(<redeszone>)

La principal diferencia entre la recogida pasiva y activa, ¿cuál es? El tráfico.

Las técnicas pasivas no generan tráfico hacia la entidad directamente de nosotros, sino que usan intermediarios, como herramientas web públicas.
Esto es importante ya que de esa manera la entidad puede ver quién le ha generado dicho tráfico, pero no quién lo ha solicitado.
Es decir, no sabe quiénes somos nosotros, los que realmente hemos pedido la información.

Esto lo diferencia al reconocimiento activo, en este las consultas SÍ las hace nuestro dispositivo directamente hacia el objetivo. Esto le permite detectar, registrar e incluso bloquearnos.

Por ejemplo al usar webs como #link("https://who.is/")[WHOIS] o #link("https://dnschecker.org/")[DNSchecker] son herramientas de recolección pasivas, mientras que herramientas como dig o nslookup ya son herramientas activas.

#pagebreak()

= Auditoría OSINT
En este caso se le hará a la empresa Banco Santander.
Este es un servicio de banca a nivel nacional e internacional. Presente, principalmente, en España y varios países de Sudamérica y Centroamérica.

Su clientela va desde particulares con pequeñas y grandes fortunas (banca privada) y autónomos, hasta empresas pequeñas y grandes, instituciones e incluso universidades.

Prestando una gran variedad de servicios dependiendo del país y de quien los solicite.
/ Particulares:
  - OpenBank
  - Santander
  - Santander Consumer Finance
  - Santander Universidades

/ Empresas:
  - Bancasar
  - Santander Advance
  - Santander Factoring & Confirming
  - Santander Trade

/ Instituciones:
  - Santander Instituciones Financieras
  - Santander Instituciones Privadas
  - Santander Instituciones Públicas

/ Corporaciones:
  - Santander Factoring & Confirming

/ Banca Privada:
  - Banca online
  - Santander Private Banking

/ Universidades:
  - Santander

Para más información de cada servicio: #cite(<Santander_servicios>)

En cuanto a sus proveedores, no se encuentra demasiada información detallada, pero los más importantes son los siguientes:
/ Microsoft: Servicios nube
  Esta empresa es el principal asociado para los servicios en la nube, para facilitar la transformación del banco al sector digital.
  Esta alianza se firmó en 2019. #cite(<Microsoft_Santander>)

/ Google: Para la creación de la herramienta Dual Run
  Una herramienta la cual ayudaría a otras empresas e industrias al cambio a la nube. #cite(<Google_Santander>)

/ AWS: Catalyst
  Junto a AWS desarrollaron esta infraestructura para los inicios de la banca digital. #cite(<AWS_Santander>)

== Presencia digital
Siguiendo con lo pedido en la práctica vamos a investigar primero los servicios y tecnologías expuestas.
Para eso lo primero que vamos a usar es la herramienta llamada BuiltWith. #cite(<BuiltWith>)

Al iniciar la búsqueda de la página web "santander.com" obtenemos una gran cantidad de datos, pero los más importantes son los siguientes:

#table(
  columns: (auto, auto),
  [*Función*], [*Tecnología*],
  [Servidor web], [Apache],
  [Tecnología del backend], [Java EE],
  [Correo corporativo], [Microsoft Exchange Online / Office 365],
  [Seguridad de correo], [Cisco IronPort Cloud],
  [Política de seguridad de correo], [SPF y DMARC Reject],
  [Seguridad web], [SSL por defecto + HSTS],
  [Certificados SSL], [GlobalSign],
  [Gestor de contenido web], [Adobe Experience Manager],
  [Librería de Javascript frontend], [jQuery 3.5.1],
)

En esta página también obtenemos información sobre la infraestructura y algunos otros proveedores:
#table(
  columns: (auto, auto),
  [*Función*], [*Tecnología*],
  [CDN y DNS principal], [Akamai Edge + DNS],
  [CDN y seguridad], [Cloudflare + Incapsula],
  [CDN secundario], [Fastly],
  [DNS secundario], [Microsoft Azure DNS],
  [Protección de bots], [Imperva],
  [Almacenamiento en nube], [Amazon S3],
  [Registro del dominio], [Tucows],
)

Estos son los más destacables.

Pasando a los registros DNS, usé la herramienta WHOIS. #cite(<whois_santander>)
Con la herramienta obtuve confirmación de alguna de la información antes mencionada. Por ejemplo:

Se confirma el registrador como Tucows Domains Inc. y algunas fechas importantes:
- Fecha de registro: 23 de abril de 1998
- Fecha de expiración: 22 de abril de 2035

Los nameservers son de Akamai, confirmando que es el que gestiona el DNS.

Comprobando el estado, veo que está protegido contra transferencia o modificación no autorizadas del dominio:
"clientTransferProhibited" y "clientUpdateProhibited"

Otros datos interesantes son el contacto del registrante, que aparece como Cantabria, algo lógico teniendo en cuenta que Banco Santander tiene su origen en esa comunidad.
#image("/assets/image.png")

Pero algo muy importante a resaltar dentro del raw data del RDAP es lo siguiente:
#image("/assets/image-1.png")

Es decir, no hay DNSSEC activo. Esto es relevante porque sin DNSSEC un atacante podría realizar un ataque de DNS spoofing, redirigiendo a los usuarios a una web falsa sin que lo detecten. Para una entidad bancaria esto supone un riesgo importante.

Ya dirigiéndome directamente a los registros DNS vemos lo siguiente:
#image("/assets/image-2.png")

De todo esto lo que realmente nos interesa es:
- Las IPs son de Akamai, confirmando el uso de su CDN.
- El registro MX nos confirma el uso de Cisco IronPort,
  ya que la infraestructura iphmx.com es propiedad de Cisco.
- Registro SOA:
  Obtenemos el servidor DNS primario, y nos damos cuenta de que es propio:
  "dns01.santandergroup.net". El email del administrador DNS muestra que usan internamente el dominio "gruposantander.com".
- Al apuntar www.santander.com a gm9f8cj.impervadns.net confirmamos la seguridad web por parte de Imperva.

Ya hemos sacado la información de la IP del servidor en el que se encuentra la web.
Como ya había comentado, está en San Mateo, California, USA. #cite(<ipinfo>)
#image("/assets/image-3.png")

Con esto vemos que tiene servicio en unos 20 países distintos, información que aparece en esta misma página al usar la IP "45.223.164.248" que obteníamos de WHOIS.

Si entramos en la propia página web de Santander en el apartado de servicios financieros podemos ver a qué países da servicio: #cite(<santander_países>)
#table(
  columns: (auto, auto),
  [*País*], [*Dominio*],
  [Alemania], [santander.de],
  [Argentina], [santander.com.ar],
  [Austria], [santanderconsumer.at],
  [Bélgica], [santander.be],
  [Brasil], [santander.com.br],
  [Chile], [banco.santander.cl],
  [Dinamarca], [santanderconsumer.dk],
  [Holanda], [santander.nl],
  [Finlandia], [santanderconsumer.fi],
  [Italia], [santanderconsumer.it],
  [México], [santander.com.mx],
  [Noruega], [santanderconsumer.no],
  [Perú], [santander.com.pe],
  [Portugal], [santander.pt],
  [Reino Unido], [santander.co.uk],
  [Uruguay], [santander.com.uy],
  [España], [bancosantander.es],
  [Estados Unidos], [santanderus.com],
)

Usando otra herramienta llamada Shodan, encontramos información muy valiosa
.#cite(<shodan_santander>)
Lo primero de todo encontramos un total de 2.680 dispositivos o servicios expuestos,
distribuidos en numerosos países como:
- Singapur (1.296)
- EEUU (410)
- India (104)
- Alemania (71)
- Brasil (69)

Y nuevamente las organizaciones que gestionan la infraestructura: Incapsula y Akamai.

Con esto ya tenemos una idea de cuál es la escala de exposición de Santander.
Además de algunos subdominios interesantes:
- `view.envio.santander.com.mx` y `cloud.envio.santander.com.mx`:
  Estos son interesantes ya que, a diferencia del resto, están alojados en Salesforce en Dallas.
  Es decir, Santander usa Salesforce para los envíos de comunicaciones a clientes en México y el subdominio tiene una infraestructura diferente.

- `kitdemgestorext.santander.com.br`:
  Una herramienta de gestión externa para Brasil, como denota el "ext".

- `santandercib.com`:
  CIB es Corporate & Investment Banking, es decir la banca corporativa y de inversiones. Un dominio separado para una línea de negocio específica.

- `santanderinsurance.com`: seguros
- `aegonsantander.pt`: Portugal, joint venture con Aegon
- `santanderconsumer.com`: consumer finance
- `www.santander.com.uy`, `supernet.santander.com.uy`, `supernetempresas.santander.com.uy`: Uruguay
- `santander-fsl.de`: Alemania

Esto nos muestra no solo algunos otros proveedores que podrían ser más susceptibles a ataques, sino también la diferenciación entre infraestructura y países, junto a posibles puntos de entrada por subdominios diferentes al principal.

Los datos de seguridad más relevantes son:
- Los certificados SSL están emitidos por GlobalSign, confirmando lo obtenido en BuiltWith.
- Todos los servicios pasan por Imperva, confirmando la protección web.
- El certificado de `www.santander.com.uy` está emitido a nombre de Banco Santander México S.A., lo que indica que esa infraestructura está gestionada desde México.

En cuanto a redes sociales, tanto BuiltWith como la propia página web de Santander confirman presencia en:
- Facebook
- Instagram
- LinkedIn
- Twitter/X
- TikTok
- YouTube
- WhatsApp (canal de atención al cliente)

== Dorking

A continuación se presentan tres ejemplos de búsquedas avanzadas mediante Google Dorking aplicadas a Banco Santander:

/ Búsqueda de páginas de transferencias expuestas:
  `site:santander.com inurl:transfer intext:€`

  Esta búsqueda intenta localizar páginas relacionadas con transferencias bancarias que contengan el símbolo del euro. Si apareciesen resultados accesibles públicamente, supondría una exposición grave de funcionalidades sensibles.

/ Búsqueda de listas de empleados:
  `site:santander.com filetype:xlsx intext:employee`

  Busca hojas de cálculo Excel publicadas en el dominio de Santander que contengan información de empleados. Un archivo de este tipo accesible públicamente podría revelar datos personales o estructuras organizativas internas.

/ Búsqueda de informes de vulnerabilidades o incidentes:
  `site:santander.com filetype:pdf intext:vulnerability OR intext:incident OR intext:outage`

  Busca documentos PDF que mencionen vulnerabilidades, incidentes o caídas de servicio. Este tipo de documentos, si estuviesen expuestos, revelaría información crítica sobre la seguridad de la infraestructura.

#pagebreak()

= Resultados

A lo largo de esta auditoría OSINT se han obtenido los siguientes hallazgos principales sobre Banco Santander:

Desde el punto de vista de la infraestructura, Santander apoya su presencia digital en una arquitectura robusta y distribuida globalmente. Akamai actúa como CDN y gestor DNS principal, con Cloudflare, Incapsula y Fastly como capas adicionales de distribución y seguridad. La protección frente a bots recae en Imperva, cuya presencia se confirma tanto en BuiltWith como en los registros CNAME y en Shodan. El dominio `santander.com` está registrado desde 1998 a través de Tucows, con renovación hasta 2035.

En cuanto a tecnologías expuestas, la web utiliza Apache como servidor, Java EE en el backend y Adobe Experience Manager como gestor de contenidos. El correo corporativo está gestionado por Microsoft Exchange y protegido por Cisco IronPort con políticas DMARC Reject y SPF activas.

Se ha identificado un hallazgo de seguridad relevante: el dominio `santander.com` no tiene DNSSEC activado, lo que lo hace teóricamente vulnerable a ataques de DNS spoofing.

La huella digital geográfica de Santander es muy extensa, con presencia confirmada en 18 países a través de dominios propios. Shodan revela 2.680 servicios expuestos distribuidos principalmente en Singapur, EEUU, India, Alemania y Brasil, gestionados mayoritariamente por Incapsula y Akamai.

Mediante el análisis de subdominios se han identificado segmentaciones interesantes de la infraestructura, como el uso de Salesforce para comunicaciones en México o la gestión de la infraestructura de Uruguay desde México.

#pagebreak()

= Conclusiones

Esta práctica ha demostrado la gran cantidad de información que se puede obtener sobre una empresa utilizando exclusivamente técnicas pasivas y fuentes públicas, sin generar ningún tráfico directo hacia sus sistemas.

Banco Santander, pese a ser una entidad bancaria con una infraestructura técnica muy madura y robusta, expone una cantidad significativa de información a través de registros DNS públicos, certificados SSL, herramientas de análisis web y motores de búsqueda especializados como Shodan.

El hallazgo más relevante desde el punto de vista de la seguridad es la ausencia de DNSSEC en el dominio principal, que podría ser explotada mediante ataques de DNS spoofing dirigidos a los clientes del banco.

En definitiva, el reconocimiento pasivo es una fase crítica en cualquier auditoría de seguridad, ya que permite construir un perfil detallado del objetivo sin alertar a sus sistemas de detección, y los resultados obtenidos en esta práctica demuestran su efectividad incluso contra organizaciones con equipos de seguridad avanzados.

#pagebreak()

#bibliography("bibliography.bib")