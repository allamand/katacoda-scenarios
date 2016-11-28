## Host a simple webpage

First, lets revise a few key concepts. 

1. The lifetime of a container is equal to the life time of the master process. If the master process is deamon such as nginx, the container runs for a longer period of time. 

2. We can use the docker run with `-d` to run the container in a daemon mode

3. We can use forward a port of the container using docker run with `-p <container port>:<host port>` 

For this step, let us `nginx`

Pull the nginx conainer:
`docker pull nginx`{{execute}}

Run the nginx container as follows:
`docker run --name=mynginx nginx`{{execute}}

You will see that the screen hangs and you do not get any output. At this time, you can try to open another terminal window.

>Now kill the container by hitting Control-C. If you revisit the page again, you will not see it. This is because the container the process have exited. 


## Start/stop and named a containers

Now re-run the same container in deamon mode using `-d` as follows: 
`docker run -d --name=mywebsite  -p 80:80 nginx`{{execute}}

- **mywebsite** is just a name, you can give your container a different name if you like. 
- **-p 80:80** allows to expose the port 80 of the container on the local port 80 of the Host where the container is run.

Now confirm that your container is running using:
`docker ps`{{execute}}
You shall see the nginx container in the list. 

you can make request to your container :

`curl http://docker:80`{{execute}}

> On KataKoda, you will be able to visit the URL https://[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com/



You can stop this container using docker `docker stop mywebsite`{{execute}}

You will again not be able to access. Now run the container with `docker start mywebsite`{{execute}}

Stop the container again. You can see the stopped containers by running `docker ps -a`{{execute}}

You can permanently delete the container by running `docker rm mywebsite`{{execute}}

