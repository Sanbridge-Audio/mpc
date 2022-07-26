FROM mesonbuild/bionic AS build
LABEL maintainer="Matt Dickinson <matt@sanbridge.org>"

#docker pull mesonbuild/bionic

RUN apt-get update && apt-get install -y \
	g++ \
	libmpdclient-dev \
	ninja-build \
	&& apt-get clean && rm -fR /var/lib/apt/lists/*
	
ARG MPC_VERSION=0.34
ADD https://www.musicpd.org/download/mpc/0/mpc-${MPC_VERSION}.tar.xz /tmp
RUN tar xf /tmp/mpc-${MPC_VERSION}.tar.xz

WORKDIR mpc-0.34/build

#Installation of MPC
RUN meson . output
RUN ninja -C output
RUN ninja -C output install
