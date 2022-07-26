FROM mesonbuild/bionic AS build
LABEL maintainer="Matt Dickinson <matt@sanbridge.org>"

#docker pull mesonbuild/bionic

RUN apt-get update && apt-get install -y \
	g++ \
	libmpdclient 2.9 \
	&& apt-get clean && rm -fR /var/lib/apt/lists/*
