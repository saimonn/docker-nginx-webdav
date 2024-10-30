FROM nginx:latest

LABEL maintainer="saimonn"

COPY webdav.conf /etc/nginx/conf.d/default.conf
COPY entrypoint.sh /

RUN apt-get update && apt-get -y dist-upgrade   && \
  apt-get install -y nginx-extras apache2-utils && \
  rm /etc/nginx/sites-enabled/*                 && \
  mkdir -p "/media/data"                        && \
  chown -R www-data:www-data "/media/data"      && \
  chmod +x entrypoint.sh

VOLUME /media/data

CMD /entrypoint.sh
