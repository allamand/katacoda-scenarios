

## Start Consul & Vault

The first step is to start an instance of Vault. We explained the details of Vault in the [Store Secrets using Hashicorp Vault scenario](https://www.katacoda.com/courses/docker-production/vault-secrets).

We've created some helper scripts to start Vault. To configure the environment run the following commands.

## Configure Vault

The first script launches the Consul and Vault containers `./start-vault.sh`{{execute}}
>You can view content of this simple script 

The Vault starts **sealed** meaning you can read/write data. Use the helper script to unseal the vault `./unseal-vault.sh`{{execute}}. If this errors, it's because Vault is still initialising.

> The unseal script produce a key.txt with keys needed to unseal your Vault. This file un production environmnent must be store in a secure location!

You can view the status of the vault using `vault status -address=${VAULT_ADDR}`{{execute}}


>You can view content of these simple scripts
>- `cat ./start-vault.sh`{{execute}}
>- `cat ./unseal-vault.sh`{{execute}}

The final stage is to obtain the access token; this is outputted when we initialised and unsealed the vault.

`export VAULT_TOKEN=$(grep 'Initial Root Token:' keys.txt | awk '{print substr($NF, 1, length($NF)-1)}'); echo VAULT_TOKEN=$VAULT_TOKEN`{{execute}}

we can now start storing and persisting data `vault auth -address=${VAULT_ADDR} ${VAULT_TOKEN}`{{execute}}

After running the commands Vault and your environment have been configured.


Check one last time your Vault status `vault status -address=${VAULT_ADDR}`{{execute}}




> for ease we used an alias for vault command `alias | grep vault`{{execute}}
