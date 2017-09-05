# Docker file for an nginx first LTM proxy
#
#
FROM alpine:latest
MAINTAINER Rufael  <rufael@unified-streaming.com>

RUN apk --update add bash curl

RUN apk --update add nginx

RUN mkdir /html/

COPY config/index.html /html/index.html

COPY config/nginx /etc/nginx

COPY config/proxy1 proxy1

#RUN cp /etc/hosts.bak /etc/hosts

RUN mkdir -p /run/nginx

#RUN mkdir /var/www/usp /var/www/ltm_demo

#RUN mkdir /var/www/usp/proxy /var/www/vod

EXPOSE 80 53 443
