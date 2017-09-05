FROM alpine:latest

MAINTAINER Rufael  <rufael@unified-streaming.com>

# Install packages
RUN apk --update add bash bash-doc bash-completion apache2 supervisor \ 
	&& rm -f /var/cache/apk/*

#RUN apk --update add mp4split mod_smooth_streaming --repository http://alpine.unified-streaming.com/repo --allow-untrusted
RUN wget -q -O /etc/apk/keys/alpine@unified-streaming.com.rsa.pub \
  http://apk.unified-streaming.com/alpine@unified-streaming.com.rsa.pub

RUN apk --update \
        --repository http://apk.unified-streaming.com/repo \
        add \
          mp4split \
          mod_smooth_streaming \
 && rm -f /var/cache/apk/*

# Configure supervisord
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Configure Origin
COPY  config/edge.conf /etc/apache2/conf.d/edge.conf

COPY config/key /home/key

RUN mkdir -p /run/apache2

RUN mkdir /var/www/usp

RUN mkdir /var/www/usp/proxy /var/www/vod

RUN mkdir /var/www/vod/ts

COPY config/index.html /var/www/usp/proxy/index.html

EXPOSE 83 85 53 443

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

