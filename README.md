<p align="center">
	<a href="https://eosio.lacchain.net">
		<img src="https://raw.githubusercontent.com/lacchain/eosio.lacchain.net/master/static/img/logos/lacchain-eosio-logo.png"
		width="400px" >
	</a>
</p>

<p align="center">
	<a href="#">
		<img src="https://img.shields.io/dub/l/vibe-d.svg" alt="MIT">
	</a>
</p>

## Descripción
Este proyecto construye la red LACChain EOSIO en un entorno local de modo que se puedan realizar pruebas antes de ser publicadas en la red pública.

### ¿Por qué usar un entorno local?
Tener un entorno local brinda una serie de beneficios que en una red pública no se puede, por ejemplo, con LACChain EOSIO de manera local se evita costos de transacciones ya que se realizan en un entorno de desarrollo y no de producción, asimismo, se acceden a los contratos de sistema para modificarlos según convenga.

Debido a la tecnología que contiene Blockchain, cualquier cambio en la red crea un registro inmutable de la acción y todo lo que se modifique puede afectar tanto positivamente como negativamente a los usuarios dentro de la misma, es por este motivo que es fundamental tener un entorno local donde se puedan realizar pruebas de funcionalidad, pruebas de rendimiento, pruebas de estrés (stress test), entre otras sin el riesgo de producir alguna falla que afecte a los usuarios.

Por último, un factor a considerar es el tiempo que se reduce en la configuración inicial de cualquier red, esta imagen permite de manera directa, con solo ejecutar dos comandos poder tener la red instalada y lista para hacer pruebas de funcionalidad según sea necesario.

### Contratos
La imagen de LACChain EOSIO usa como base el contrato de `lacchain.system` para su configuración de gobernanza. Su código se encuentra en [este enlace](https://github.com/lacchain/eosio.contracts/tree/dev/contracts/lacchain.system). Adicionalmente, se requiere los siguientes contratos como parte del proceso de la configuración completa:
1. **lacchain.system**: Brinda las reglas de gobernanza establecidas por la red de LACChain EOSIO. Consultar [este enlace](https://eosio.lacchain.net/en/docs/eosio/) para más información.
2. **eosio.token**: Define las estructuras y acciones que permiten a los usuarios crear, emitir y administrar tokens para cadenas de bloques basadas en EOSIO.
3. **eosio.msig**: Permite la creación de transacciones propuestas que requieren la autorización de una lista de cuentas.

### Key de configuración
La llave preconfigurada es la de eosio que permite realizar la configuración inicial de la red. Puede consultarla [aquí](https://github.com/lacchain/lacchain-eosio-local/blob/main/Dockerfile#L43).
```
EOSIO_PRIVATE_KEY: 5KQwrPbwdL6PhXujxW37FSSQZ1JiwsST4cqQzDeyXtP79zkvFD3
EOSIO_PUBLIC_KEY:  EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV
```

### Prerrequisitos
- [Git](https://git-scm.com/)
- [Node.js](https://nodejs.org/en/)
- [Docker](https://www.docker.com/)
- [Eosio](https://developers.eos.io/welcome/latest/getting-started-guide/local-development-environment/index)

## Inicio rápido
- Descargue la imagen de Docker `docker pull eoscostarica506/lacchain-eosio-local`
- Ejecute la imagen de Docker `docker run -dp 8888:8888 eoscostarica506/lacchain-eosio-local`
- Ejecute el comando `cleos get info` o revise en el navegador el enlace `http://127.0.0.1:8888/v1/chain/get_info`

Si ejecuta el comando `cleos get info` o accede a `http://127.0.0.1:8888/v1/chain/get_info` y obtiene información como la siguiente es porque ya tiene el entorno listo para trabajar.

```
{"server_version":"e57a1eab","chain_id":"981453d176ddca32aa278ff7b8af9bf4632de00ab49db273db03115705d90c5a","head_block_num":7,"last_irreversible_block_num":6,"last_irreversible_block_id":"00000006ce0e04cb174e797d1f910945d1ba1c82d925c0f0e3721e392e72e37d","head_block_id":"0000000728b21e87b801d17207477c9cc057e1ff7535ce4c4bae5c38d779f531","head_block_time":"2021-07-06T20:42:24.000","head_block_producer":"eosio","virtual_block_cpu_limit":201202,"virtual_block_net_limit":1054885,"block_cpu_limit":199900,"block_net_limit":1048576,"server_version_string":"v2.0.12","fork_db_head_block_num":7,"fork_db_head_block_id":"0000000728b21e87b801d17207477c9cc057e1ff7535ce4c4bae5c38d779f531","server_full_version_string":"v2.0.12-e57a1eab619edffc25afa7eceb05a01ab575c34a"}
```

## Instrucciones para crear la imagen de LACChain EOSIO localmente
Para crear la imagen de Docker de manera local debe ejecutar los siguientes comandos:
- Clone el repositorio local de LACChain EOSIO `https://github.com/lacchain/lacchain-eosio-local.git`
- Ingrese a la carpeta del repositorio clonado `cd <path/lacchain-eosio-local>`
- Construya la imagen del Dockerfile `docker build -t lacchain-eosio-local .`
- Ejecute la imagen del Dockerfile `docker run -dp 8888:8888 lacchain-eosio-local`
- Ejecute el comando `cleos get info` o revise en el navegador el enlace `http://127.0.0.1:8888/v1/chain/get_info`

Para este punto, ya tiene la imagen de la red de LACChain EOSIO corriendo de manera local.

## Estructura de archivos
```text title="./lacchain-eosio-local"
/
├── .github
│   └── workflows
│       └── publish-docker-image.yml
├── config.ini ............... Archivo de configuración de nodeos
├── Dockerfile ............... Contiene las instrucciones para construir la imagen de LACChain EOSIO
├── genesis.json ............. Especifica los parámetros del nodo de génesis de la red
├── LICENSE .................. Términos y Condiciones
├── README.md ................ Especificación del repositorio
└── start.sh ................. Instrucciones para configurar contratos y características de uso
```

## Licencia
MIT © [EOS Costa Rica](https://eoscostarica.io/)

## Contribuir
Si quiere hacer alguna contribución a este repositorio, por favor siga los siguientes pasos:

1. Haga Fork al proyecto
2. Cree una nueva rama (`git checkout -b feat/sometodo`)
3. Haga Commit de los cambios (`git commit -m '<type>(<scope>): <subject>'`)
4. Haga Push del commit (`git push origin feat/sometodo`)
5. Abra un Pull Request

Lea las [pautas de contribución](https://guide.eoscostarica.io/docs/open-source-guidelines/) de código abierto de EOS Costa Rica para obtener más información sobre las convenciones de programación.

Si encuentra algún bug, infórmelo abriendo un issue en [este enlace](https://github.com/lacchain/lacchain-eosio-local/issues).


## ¿Qué es LACChain?
LACChain es la Alianza Global para el desarrollo del ecosistema blockchain en América Latina y el Caribe, una iniciativa liderada por BID Lab (Laboratorio de Innovación del grupo Banco Interamericano de Desarrollo). Su objetivo es acelerar la habilitación y la adopción de la tecnología blockchain para el fomento de la innovación, la reducción de las desigualdades y el impacto en inclusión. Para ello, LACChain se enfoca en dos grandes pilares: comunidad e infraestructura. Además, busca desarrollar y promover interoperabilidad de redes, así como desplegar y mantener infraestructuras blockchain interoperables. LACChain Blockchain Networks, utiliza tecnologías Hyperledger Besu y EOSIO.

## Acerca de EOS Costa Rica
<br>
<center>
<img src="https://raw.githubusercontent.com/eoscostarica/design-assets/master/logos/eosCR/fullColor-horizontal-transparent-white.png" width="400" >
</center>
<br>

EOS Costa Rica es un productor de bloques independiente, autofinanciado y de bare-metal de Genesis que proporciona una infraestructura estable y segura para EOSIO blockchains. Apoyamos el software de código abierto para nuestra comunidad al mismo tiempo que ofrecemos desarrollo de blockchain empresarial y desarrollo de contratos inteligentes personalizados para nuestros clientes.

[eoscostarica.io](https://eoscostarica.io/)