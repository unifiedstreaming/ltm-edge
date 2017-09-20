FROM alpine:latest

MAINTAINER Rufael  <rufael@unified-streaming.com>

# Install packages
RUN apk --update add bash bash-doc bash-completion apache2 supervisor nodejs nodejs-npm

# Configure supervisord
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN mkdir -p /run/apache2

COPY  config/ltm.conf /etc/apache2/conf.d/ltm.conf

RUN mkdir /var/www/usp /var/www/ltm_demo

COPY config/ltm_demo /var/www/ltm_demo
RUN cd /var/www/ltm_demo/players/dash.js-2.6.0/ && npm install -g grunt-cli && npm install && grunt && npm prune --production

EXPOSE 80 53 443

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

