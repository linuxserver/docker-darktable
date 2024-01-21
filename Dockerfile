FROM ghcr.io/linuxserver/baseimage-kasmvnc:alpine319

# set version label
ARG BUILD_DATE
ARG VERSION
ARG DARKTABLE_VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="thelamer"

# title
ENV TITLE=darktable

RUN \
  echo "**** install packages ****" && \
  if [ -z ${DARKTABLE_VERSION+x} ]; then \
    DARKTABLE_VERSION=$(curl -sL "http://dl-cdn.alpinelinux.org/alpine/v3.19/community/x86_64/APKINDEX.tar.gz" | tar -xz -C /tmp \
    && awk '/^P:darktable$/,/V:/' /tmp/APKINDEX | sed -n 2p | sed 's/^V://'); \
  fi && \
  apk add --no-cache \
    darktable==${DARKTABLE_VERSION} && \
  mkdir -p /usr/share/locale && \
  echo "**** cleanup ****" && \
  rm -rf \
    /tmp/*

# add local files
COPY /root /

# ports and volumes
EXPOSE 3000

VOLUME /config
