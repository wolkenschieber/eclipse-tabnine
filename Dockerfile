FROM ghcr.io/linuxserver/baseimage-kasmvnc:debianbookworm

ARG ECLIPSE_VERSION=2023-12
ARG TABNINE_VERSION=LATEST
ARG DEBIAN_FRONTEND=noninteractive

LABEL build_version="Eclipse ${ECLIPSE_VERSION} using Tabnine ${TABNINE_VERSION}"
LABEL maintainer="wolkenschieber"

ENV TITLE=Eclipse-Tabnine
ENV FM_HOME=/config/eclipse

RUN \
  apt-get update \
  # Install browser and dependencies
  && apt-get install -y --no-install-recommends \
  curl firefox-esr libswt-gtk-4-java libwebkit2gtk-4.1-0 \
  # Clean up
  && apt-get autoclean \
  && rm -rf \
  /config/.cache \
  /var/lib/apt/lists/* \
  /var/tmp/* \
  /tmp/* 

RUN \
  # Download Eclipse
  curl -SL -o /tmp/eclipse-rcp.tar.gz 'https://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/2023-12/R/eclipse-rcp-2023-12-R-linux-gtk-x86_64.tar.gz&r=1' \
  # Install Eclipse
  && tar xf /tmp/eclipse-rcp.tar.gz -C /opt \
  # Install TabNine Plug-in
  && /opt/eclipse/eclipse -nosplash -application org.eclipse.equinox.p2.director -repository https://eclipse-update-site.tabnine.com/Tabnine/latest -installIU com.tabnine.eclipse.feature.feature.group \
  # Clean up
  && rm -rf \
  /config/.cache \
  /var/lib/apt/lists/* \
  /var/tmp/* \
  /tmp/* 

COPY /root /

EXPOSE 3000

VOLUME /config
