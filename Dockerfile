FROM nginx:1.15.6

LABEL maintainer="alaluces"

RUN  mkdir -p /etc/nginx/sites-enabled /etc/ssl/certs/custom 

# Configure nginx
COPY ./files/nginx/nginx.conf /etc/nginx/nginx.conf
COPY ./files/nginx/default_server.conf /etc/nginx/sites-enabled/default.conf
COPY ./files/nginx/http.conf /etc/nginx/sites-enabled/http.conf

# SSL
COPY ./files/ssl/ca.crt /etc/ssl/certs/custom/ca.crt
COPY ./files/ssl/cert.crt /etc/ssl/certs/custom/cert.crt
COPY ./files/ssl/privkey.key /etc/ssl/certs/custom/privkey.key

RUN ln -sf /dev/stdout /var/log/nginx/access.log \
        && ln -sf /dev/stderr /var/log/nginx/error.log

ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

EXPOSE 80 443
