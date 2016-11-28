# Step2 - Create Data

With Vault started, use the CLI to persist the secrets required by your applications. Vault can store any sensitive information, such as passwords, certificates or keys.

## Save Data

Run the following command to write data into the Vault. Vault will encrypt the data before storing it in Consul. The name of the key is db-password which we're storing under the collection app-1. By grouping secrets around applications makes them easier to manage. It also allows you to add restrictions to only allow certain users to access certain groups.

`vault write -address=${VAULT_ADDR} \
  secret/app-1/db-password value=mysecretpassword`{{execute}}
  
>  Note: If you're using the CLI to populate Vault, ensure you don't persist the commands to your bash history file. You can write data to Vault in multiple ways. 

For example via a file with `vault write secret/password value=@data.txt`.

## Read Data

We can also used this to reead datas:

`vault read -address=${VAULT_ADDR} \
  -field=value secret/app-1/db-password`{{execute}}
  

## HTTP API

You can also use the HTTP API to interract with the vault:

`curl -H "X-Vault-Token:$VAULT_TOKEN" \
  -XGET http://docker:8200/v1/secret/app1/db-password`{{execute}}

and we can extract only fields we wants with :

`curl -s -H  "X-Vault-Token:$VAULT_TOKEN" \
  -XGET http://docker:8200/v1/secret/app1/db-password \
    | jq -r .data.value`{{execute}}
