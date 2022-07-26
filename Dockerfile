ARG MPC_VERSION=0.34

FROM debian:stable-slim AS build

LABEL maintainer="Matt Dickinson <matt@sanbridge.org>"

#docker pull mesonbuild/bionic

RUN apt-get update && apt-get install -y \
	g++ \
	libmpdclient-dev \
	meson \
	ninja-build \
	xz-utils \
	pkg-config \
	git \
	&& apt-get clean && rm -fR /var/lib/apt/lists/*
	
	
RUN git clone https://github.com/MusicPlayerDaemon/mpc
#ARG MPC_VERSION=0.34
##ADD https://www.musicpd.org/download/mpc/0/mpc-${MPC_VERSION}.tar.xz /tmp
#RUN tar xf /tmp/mpc-0.34.tar.xz

WORKDIR mpc

#Installation of MPC
RUN meson . output
RUN ninja -C output
RUN ninja -C output install

FROM debian:stable-slim AS final
#ARG MPC_VERSION=0.34
#WORKDIR $HOME
#RUN mkdir -p /usr/local/bin/mpc

COPY --from=build /usr/local/bin/mpc /usr/local/bin

RUN apt-get update && apt-get install -y \
	libmpdclient-dev \
	iproute2 \
	mosquitto-clients \
	&& apt-get clean && rm -fR /var/lib/apt/lists/*
ENV MPD_HOST=mpd 	
#ENV mpc=$MPC_VERSION
#CMD ["mpc", "-h mpd"]
