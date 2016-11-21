

## Docker Compose

Go to the stack directory `cd example-voting-app`{{execute}} and launch the app using docker-compose `docker-compose up -d`{{execute}}.

You can viex the status of your deployment using `docker-compose ps`{{execute}}

To launch the GC scheduler as a container we need to provide access to the _docker.sock_ file and _/etc_ on the host. This allows the GC to run in the background as a container. 

## Task

Launch the process with the following command:

`docker run --rm \
   -v /var/run/docker.sock:/var/run/docker.sock \
   -v /etc:/etc spotify/docker-gc`{{execute}}

In the next step we'll explain how you can customise the GC settings.

Now You can check that old unused images has been remooved:

`docker images`{{execute}}
