# Docker file for an nginx first LTM proxy
FROM alpine:latest

MAINTAINER Rufael  <rufael@unified-streaming.com>

RUN apk --update add bash curl

RUN apk --update add nginx

RUN mkdir /html/

COPY config/index.html /html/index.html

COPY config/nginx /etc/nginx

RUN mkdir -p /run/nginx

EXPOSE 80 53 443
