FROM ghcr.io/linuxserver/baseimage-alpine-nginx:3.12

# set version label
ARG BUILD_DATE
ARG VERSION
ARG HEIMDALL_RELEASE
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="aptalca"

# environment settings
ENV S6_BEHAVIOUR_IF_STAGE2_FAILS=2

RUN \
 echo "**** install runtime packages ****" && \
 apk add --no-cache --upgrade \
	curl \
	php7-ctype \
	php7-curl \
	php7-pdo_pgsql \
	php7-pdo_sqlite \
	php7-pdo_mysql \
	php7-tokenizer \
	php7-zip \
	tar \
	git

RUN echo "**** install heimdall ****" && \
	mkdir -p /heimdall && \
	curl -o /heimdall/heimdall.tar.gz -L \
	"https://github.com/OllieJC/Heimdall/archive/refs/tags/2.2.3.tar.gz" && \
	echo "**** cleanup ****" && \
	rm -rf /tmp/*

# add local files
COPY root/ /
