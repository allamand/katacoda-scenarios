
# Docker Volume Driver



With the data saved, we now need our Docker Container to be able to read and access the secret, in this case, our password. We'll do this by using a 3rd party Docker Volume Driver called LibSecret. Volume drivers are plugins that extend Docker. Docker will communicate with the plugin when accessing the file-system.
Launch Plugin

The plugin is required to run as a background job on your Docker host. Nohup is a Ubuntu application which allows you to run tasks in the background and terminated when the system reboots. To have processes persisted would require using SystemD.

When launching LibSecret we define the Vault address and an access token. At the moment, all containers will use the same access token.

`sudo nohup ./docker-volume-libsecret \
  --addr $VAULT_ADDR \
    --backend vault \
	  --store-opt token=$VAULT_TOKEN </dev/null &>/dev/null &`{{execute}}

## Start Container
	  
For containers to utilise the Volume Driver we need to specify when the container is launched via --volume-driver parameter. Using the Volume parameter, we map a Vault collection to a file-system folder. In this case, we're mapping secret/app-1 in Vault to a folder called /secrets.
	  
`docker run -ti --rm \
  --volume-driver libsecret \
  -v secret/app-1/:/secrets \
  alpine ash`{{execute}}
			
Our container never has access to Vault or access token. Everything is managed via the Volume Driver. In the next step we'll read the secrets.

From Here our shell is inside the alpine container.

Try to see the content of the /secrets directoty

`ls -la /secrets`{{execute}}

> You find that this directory seams empty.. this is by design and ensures that attackers cannot easily view all the available contents!!

We ask the container to have access to all **keys** in the **app-1** collection.
It will not be able to access keys in other collections.

Each key within our collection is accessed as a file, For example, to read decrypted value of **db-password** we need to read that file :

`cat secrets/db-password`{{execute}}

The Volume Driver only provides read access to Vault, meaning that we cannot change values :

`echo 'Will this be stored?' > secrets/db-password`{{execute}}
