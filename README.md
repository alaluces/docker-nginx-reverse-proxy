# Docker-Nginx-Ingress
An NGINX front controller

### INSTALLATION
Install docker-ce

Clone the project
```sh
mkdir ingress
cd ingress
git clone https://github.com/alaluces/Docker-Nginx-Ingress.git .
```

Place your ssl cert files under files/ssl directory 
Edit files/nginx/default_server.conf to set your routes/backends

Build the docker image
```sh
docker build -t ingress .
```

Run the image you built
```sh
docker run -d --rm -p80:80 -p443:443 --name ingress ingress
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


