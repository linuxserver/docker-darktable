FROM ghcr.io/linuxserver/baseimage-kasmvnc:arch

# set version label
ARG BUILD_DATE
ARG VERSION
ARG DARKTABLE_VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="thelamer"

# title
ENV TITLE=darktable

RUN \
  echo "**** install runtime packages ****" && \
  pacman -Syu --noconfirm --needed \
    darktable \
    portmidi && \
  echo "**** cleanup ****" && \
  rm -rf \
    /tmp/* \
    /var/cache/pacman/pkg/* \
    /var/lib/pacman/sync/*

# add local files
COPY /root /

# ports and volumes
EXPOSE 3000
