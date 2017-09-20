FROM ubuntu:xenial

MAINTAINER Karl Ma
ENV REFRESHED_AT 2017-09-06

# Change sourcelist to aliyun
COPY sources.list /etc/apt/

# gcc for cgo
RUN apt-get update && apt-get install -y --no-install-recommends \
		g++ \
		gcc \
		libc6-dev \
		make \
		pkg-config \
		wget \
	&& rm -rf /var/lib/apt/lists/*

ENV GOLANG_VERSION 1.8.3

ADD go1.8.3.linux-amd64.tar.gz /usr/local/

RUN set -eux; \
	export PATH="/usr/local/go/bin:$PATH"; \
	go version

ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"
WORKDIR $GOPATH

#COPY go-wrapper /usr/local/bin/
