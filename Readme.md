# Readme

The image provides an isolated environment to test the AI assistant [Tabnine](https://www.tabnine.com/) in [Eclipse](https://www.eclipse.org/).

## Docker Compose

### Volumes

#### Creating data volume

The user's id in the image is _911_. Thus the permissions of the mounted volume must be set accordingly:
```sh
mkdir -p data/sources \
    && sudo chown -R 911:911 data \
    && sudo chmod -R ugo+rwxs data 
```
#### Cloning sources

Clone sources via git into directory `/data/sources` via container's Eclipse.

#### Copying sources

Sources should be deployed to `data/sources`. After the deployment the file permissions need to be updated:
```sh
sudo chown --reference data -R data/sources
```
### Run

```sh
docker compose up -d
```
### Build

```sh
docker compose -f docker-compose.yml -f docker-compose.build.yml build
```

## Docker

### Build

```sh
docker build --tag wolkenschieber/eclipse-tabnine:latest .
```
### Run 

#### Background

```sh
docker run --detach \
    -e TZ=Europe/Berlin \
    -p 3000:3000 \
    --name eclipse-tabnine \
    --shm-size="1gb" \
    wolkenschieber/eclipse-tabnine:latest
```

#### Diagnostic

```sh
docker run --rm -it \
    -e TZ=Europe/Berlin \
    -p 3000:3000 \
    --name eclipse-tabnine \
    --shm-size="1gb" \
    wolkenschieber/eclipse-tabnine:latest \
    bash
```

## Links

* [linuxserver/kasmvnc](https://github.com/linuxserver/docker-baseimage-kasmvnc)
* [wolkenschieber/docker-chromium](https://github.com/wolkenschieber/docker-chromium/tree/master)
* [SO - How to download eclipse marketplace plugins for offline install](https://stackoverflow.com/questions/70746838/how-to-download-eclipse-marketplace-plugins-for-offline-install)
* [Eclipse - Installing software using the p2 director application](https://help.eclipse.org/latest/index.jsp?topic=/org.eclipse.platform.doc.isv/guide/p2_director.html)
* [Eclipse - The SWT FAQ](https://www.eclipse.org/swt/faq.php#browserlinux)
* [Eclipse - Runtime options](https://help.eclipse.org/latest/index.jsp?topic=%2Forg.eclipse.platform.doc.isv%2Freference%2Fmisc%2Fruntime-options.html)