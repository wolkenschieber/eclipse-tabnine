# Readme

This project provides an isolated environment to test the AI assistant [Tabnine](https://www.tabnine.com/) in [Eclipse](https://www.eclipse.org/). 

Docker images are available on [dockerhub](https://hub.docker.com/r/wolkenschieber/eclipse-tabnine):
| Image                                           | Arch    |
| ----------------------------------------------- | ------- |
| `wolkenschieber/eclipse-tabnine:latest`         | `amd64` |

## Docker

### Run 

#### Background

```sh
docker run --detach \
    -e PUID=1000 \
    -e PGID=1000 \
    -e TZ=Europe/Berlin \
    -p 3000:3000 \
    -v /config \
    --name eclipse-tabnine \
    --shm-size="1gb" \
    wolkenschieber/eclipse-tabnine:latest
```
#### Diagnostic

```sh
docker run --rm -it \
    -e ECLIPSE_DEBUG=1 \
    -e PUID=1000 \
    -e PGID=1000 \
    -e TZ=Europe/Berlin \
    -p 3000:3000 \
    --name eclipse-tabnine \
    --shm-size="1gb" \
    wolkenschieber/eclipse-tabnine:latest \
    bash
```
### Pull

```sh
docker pull wolkenschieber/eclipse-tabnine:latest
```
### Build

```sh
docker build --tag wolkenschieber/eclipse-tabnine:latest .
```

## Docker Compose

This project provides a sample [docker-compose.yml](https://github.com/wolkenschieber/eclipse-tabnine/blob/master/docker-compose.yml) file. The setup provides persistence.

### Run

```sh
docker compose up -d
```
### Pull

```sh
docker compose pull
```
### Build

```sh
docker compose -f docker-compose.yml -f docker-compose.build.yml build
```
### Proxy

The container follows default proxy environment variables:
```yaml
environment:
    - "HTTP_PROXY=http://proxyhost:8080"
    - "HTTPS_PROXY=http://proxyhost:8080"      
    - "NO_PROXY=127.0.0.1"
```
## Parameters

| Parameter | Function |
| :----: | --- |
| `-p 3000` | Eclipse-Tabnine desktop gui. |
| `-e PUID=1000` | for UserID |
| `-e PGID=1000` | for GroupID |
| `-e TZ=Etc/UTC` | specify a timezone to use |
| `-e ECLIPSE_DEBUG=1` | run Eclipse with program args `-consoleLog -debug` |
| `-e ECLIPSE_RUN_AS_ROOT=1` | run Eclipse as root |
| `-v /config` | Users home directory in the container, stores program settings. |
| `--shm-size=` | This is needed for electron applications to function properly. |

## Links

* [wolkenschieber/eclipse-tabnine](https://hub.docker.com/r/wolkenschieber/eclipse-tabnine)
* [linuxserver/kasmvnc](https://github.com/linuxserver/docker-baseimage-kasmvnc)
* [wolkenschieber/docker-chromium](https://github.com/wolkenschieber/docker-chromium/tree/master)
* [SO - How to download eclipse marketplace plugins for offline install](https://stackoverflow.com/questions/70746838/how-to-download-eclipse-marketplace-plugins-for-offline-install)
* [Eclipse - Installing software using the p2 director application](https://help.eclipse.org/latest/index.jsp?topic=/org.eclipse.platform.doc.isv/guide/p2_director.html)
* [Eclipse - The SWT FAQ](https://www.eclipse.org/swt/faq.php#browserlinux)
* [Eclipse - Runtime options](https://help.eclipse.org/latest/index.jsp?topic=%2Forg.eclipse.platform.doc.isv%2Freference%2Fmisc%2Fruntime-options.html)
