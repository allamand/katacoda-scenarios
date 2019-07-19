While running a single container is useful, it is far more useful to be able to run multiple containers in tandem such that an entire application can be run. Docker makes this feature available through docker-compose. 

## linking services together with Docker Compose

Cleanup previous deployment
`docker rm -f mywebsite`{{execute}}

Analyze the following `docker-compose.yml` file. 

<pre class="file" data-filename="docker-compose.yml" data-target="append">
version: '2'

services:

  wordpress:
    image: wordpress
    ports:
      - 80:80
    environment:
      WORDPRESS_DB_PASSWORD: example

  mysql:
    image: mariadb
    environment:
      MYSQL_ROOT_PASSWORD: example
</pre>

Now run this file as:
`docker-compose up -d`{{execute}}


You may be able to reach you application on the URL https://[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com/

> You have now a Wordpress working ;)
