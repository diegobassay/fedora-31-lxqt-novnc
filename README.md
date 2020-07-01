# fedora-31-lxqt-novnc
Imagem Docker para Fedora 31 com as instalações e configurações do TigerVNC e noVNC.

## Pré-requisitos

* Docker version 19.03.8
* Docker-Compose version 1.25.0

## Para executar o projeto
Para construir e executar o projeto rodar os seguintes comandos na raiz do projeto:
```
docker-compose up
```
ou
```
docker build -t fedora-31-lxqt-novnc -f Dockerfile .

docker run --rm --p 5101:5901 --p 5100:6080 --name fedora-31-lxqt-novnc-containner fedora-31-lxqt-novnc:latest
```

## Para executar
1 - Acessar a url abaixo no navegador (Firefox/Chrome/IE/Opera):
```
http://localhost:5100
```
Digitar credencial: budi

2 - Abrir um cliente de VNC:
```
VNC Host: vnc://0.0.0.0:5101
VNC Pass: budi
```
## Demonstração
![vnc](https://github.com/diegobassay/fedora-31-lxqt-novnc/blob/master/screenshot.png)
