# docker-nginx-reverse-proxy
A Docker based NGINX reverse proxy for static and dynamic web pages

### INSTALLATION
Install docker-ce

Clone the project
```sh
git clone https://github.com/alaluces/docker-nginx-reverse-proxy.git ingress
cd ingress
```
Build the docker image
```sh
docker build -t ingress .
```

### RUN THE INGRESS WITH SSL / LETSENCRYPT

Run the image you built
```sh
docker run -d --rm --name ingress  \
-v /etc/letsencrypt/:/etc/letsencrypt/ \
-v /root/webfiles/:/var/www/html/ \
-v /root/ingress/certbot/:/var/www/certbot/ \
-v /root/ingress/nginx/nginx.conf:/etc/nginx/nginx.conf \
-v /root/ingress/nginx/sites-enabled:/etc/nginx/sites-enabled/ \
-p 80:80 -p 443:443 ingress
```

Generate letsencrypt cert for you domain
```sh
certbot certonly -d example.com -d www.example.com --webroot -w /root/ingress/certbot/
```

Take note of the directory where the cert files are generated and
place it on the default.conf nginx file
```sh
vim /root/ingress/files/sites-enabled/default.conf
```

restart the ingress container
```sh
docker restart ingress
```

Automate the renewal process
```sh
0 0 * * 0 /usr/bin/certbot renew --webroot -w /root/ingress/certbot/
30 0 * * 0 /usr/bin/docker restart ingress
```

SSH into the container
```sh
docker exec -ti ingress /bin/bash
```

If built successfully, it can be viewed on:
```sh
http://localhost/
or
https://localhost/
```


