# Docker-Nginx-Ingress
An NGINX front controller

### INSTALLATION
Install docker-ce

Clone the project
```sh
git clone https://github.com/alaluces/Docker-Nginx-Ingress.git ingress
cd ingress
```
Build the docker image
```sh
docker build -t ingress .
```

### RUN THE INGRESS WITH SSL / LETSENCRYPT
Create a folder for the letsencrypt challenge file
```sh
mkdir /root/certbot/acme-challenge/
```

Run the image you built
```sh
docker run -d --rm --name ingress  \
-v /etc/letsencrypt/:/etc/letsencrypt/ \
-v /root/certbot/acme-challenge/:/var/www/certbot/ \
-v /root/ingress/files/nginx/nginx.conf:/etc/nginx/nginx.conf \
-v /root/ingress/files/nginx/sites-enabled:/etc/nginx/sites-enabled/ \
-p 80:80 -p 443:443 ingress
```

Generate letsencrypt cert for you domain
```sh
certbot certonly -d example.com -d www.example.com --webroot -w /root/certbot/acme-challenge/
```

Take note of the directory where the cert files are generated and
place it on the default.conf nginx file
```sh
vim /root/ingress/files/nginx/sites-enabled/default.conf
```

restart the ingress container
```sh
docker restart ingress
```

Automate the renewal process
```sh
0 0 * * 0 /usr/bin/certbot renew --webroot -w /root/certbot/acme-challenge/
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


