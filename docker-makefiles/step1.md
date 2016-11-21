This scenario has a Dockerfile which defines a Docker container to output the current date.

You can view content of the Dockerfile : `cat Dockerfile`{{execute}}

## build a container 

The command `docker build -t docker-make-example .` will create a Docker image with a friendly tag  _docker-make-example_ which we can use when starting a container based on the image.

In the next step we'll demostrate how to use this command inside a Makefile.
