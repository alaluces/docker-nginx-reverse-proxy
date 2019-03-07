FROM nginx:1.15.6

LABEL maintainer="alaluces"

RUN  mkdir -p /etc/nginx/sites-enabled \
     /etc/letsencrypt \
     /var/www/certbot

RUN ln -sf /dev/stdout /var/log/nginx/access.log \
        && ln -sf /dev/stderr /var/log/nginx/error.log

ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

EXPOSE 80 443
