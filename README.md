<p align="center">
	<a href="https://eosio.lacchain.net">
		<img src="https://raw.githubusercontent.com/lacchain/eosio.lacchain.net/master/static/img/logos/lacchain-eosio-logo.png"
		width="400px" >
	</a>
</p>

<p align="center">
	<a href="https://git.io/col">
		<img src="https://img.shields.io/badge/%E2%9C%93-collaborative_etiquette-brightgreen.svg" alt="Collaborative">
	</a>
	<a href="#">
		<img src="https://img.shields.io/dub/l/vibe-d.svg" alt="MIT">
	</a>
</p>

## Descripción
Este proyecto construye la red LACChain en un entorno local de modo que se puedan realizar pruebas antes de ser publicada en la red pública.

### Prerrequisitos
- [Git](https://git-scm.com/)
- [Node.js](https://nodejs.org/en/)
- [Docker](https://www.docker.com/)

## Inicio rápido
- Descargue la imagen de Docker `docker pull eoscostarica506/lacchain-eosio-local`
- Ejecute la imagen de Docker `docker run -dp 8888:8888 eoscostarica506/lacchain-eosio-local`
- Revise `http://127.0.0.1:8888/v1/chain/get_info`

Si puede acceder a `http://127.0.0.1:8888/v1/chain/get_info` y tiene información como la siguiente es porque ya tiene el enterno listo para trabajar.

```
{"server_version":"e57a1eab","chain_id":"981453d176ddca32aa278ff7b8af9bf4632de00ab49db273db03115705d90c5a","head_block_num":7,"last_irreversible_block_num":6,"last_irreversible_block_id":"00000006ce0e04cb174e797d1f910945d1ba1c82d925c0f0e3721e392e72e37d","head_block_id":"0000000728b21e87b801d17207477c9cc057e1ff7535ce4c4bae5c38d779f531","head_block_time":"2021-07-06T20:42:24.000","head_block_producer":"eosio","virtual_block_cpu_limit":201202,"virtual_block_net_limit":1054885,"block_cpu_limit":199900,"block_net_limit":1048576,"server_version_string":"v2.0.12","fork_db_head_block_num":7,"fork_db_head_block_id":"0000000728b21e87b801d17207477c9cc057e1ff7535ce4c4bae5c38d779f531","server_full_version_string":"v2.0.12-e57a1eab619edffc25afa7eceb05a01ab575c34a"}
```

## Empecemos
Para crear la imagen de Docker de manera local se debe ejecutar los siguientes comandos:
- Clone el repositorio local de lacchian eosio `https://github.com/eoscostarica/lacchain-eosio-local.git`
- Ingrese a la carpeta del respositorio clonado `cd <path/lacchain-eosio-local>`
- Contruya la imagen del Dockerfile `docker build -t lacchain-eosio-local .`
- Ejecute la imagen del Dockerfile `docker run -dp 8888:8888 lacchain-eosio-local`
- Revise `http://127.0.0.1:8888/v1/chain/get_info`

Para este punto, ya tiene la imagen de la red de LACChain EOSIO corriendo de manera local.

## Estructura de archivos
```text title="./lacchain-eosio-local"
/
├── .github
│   └── workflows
│       └── publish-docker-image.yml
├── config.ini
├── Dockerfile
├── genesis.json
├── LICENSE
├── README.md
└── start.sh
```

## Licencia
MIT © [EOS Costa Rica](https://eoscostarica.io/)

## Contribuir
Si quiere hacer alguna contribución a este repositor, por favor siga los siguientes pasos:

1. Haga Fork al proyecto
2. Create una nueva rama (`git checkout -b feat/sometodo`)
3. Haga Commit de los cambios (`git commit -m '<type>(<scope>): <subject>'`)
4. Haga Push del commit (`git push origin feat/sometodo`)
5. Abra un Pull Request

Lea las [pautas de contribución](https://guide.eoscostarica.io/docs/open-source-guidelines/) de código abierto de EOS Costa Rica para obtener más información sobre las convenciones de programación.

Si encuentra algún bug, informelo abriendo un issue en [este enlace](https://github.com/eoscostarica/lacchain-eosio-local/issues).


## Acerca de EOS Costa Rica
<div style={{ display: "block", textAlign: "center" }}>
<img style={{ width: "50%" }} src="https://raw.githubusercontent.com/eoscostarica/design-assets/master/logos/eosCR/fullColor-horizontal-transparent-white.png" />
</div>

EOS Costa Rica es un productor de bloques independiente, autofinanciado y de bare-metal de Genesis que proporciona una infraestructura estable y segura para EOSIO blockchains. Apoyamos el software de código abierto para nuestra comunidad al mismo tiempo que ofrecemos desarrollo de blockchain empresarial y desarrollo de contratos inteligentes personalizados para nuestros clientes.

[eoscostarica.io](https://eoscostarica.io/)