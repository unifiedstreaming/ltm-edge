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
COPY config/origin.conf /etc/apache2/conf.d/origin.conf
RUN echo "LoadModule logio_module /usr/lib/apache2/mod_logio.so" >> /etc/apache2/httpd.conf
RUN echo "LogFormat \"%I %O\" requestsize" >> /etc/apache2/httpd.conf

COPY scripts/obtain_size.sh /root/obtain_size.sh
RUN chmod +x /root/obtain_size.sh

COPY scripts/purge_cache.sh /root/purge_cache.sh
RUN chmod +x /root/purge_cache.sh

COPY scripts/cache_control.sh /root/cache_control.sh
RUN chmod +x /root/cache_control.sh

COPY config/key /home/key

# Add application

RUN mkdir -p /run/apache2

RUN mkdir /var/www/usp

RUN mkdir /var/www/usp/proxy /var/www/vod

RUN mkdir /var/www/vod/video

RUN mkdir /var/www/vod/video/ts

COPY video_files/ts.ismv /var/www/vod/video/ts/ts.ismv
#COPY video_files/ts.isma /var/www/vod/video/ts/ts.isma
COPY video_files/ts.ism /var/www/vod/video/ts/ts.ism

COPY config/index.html /var/www/vod/video/index.html

COPY config/index.html /var/www/vod/index.html

EXPOSE 82 84 53 443

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
