echo 'backend "consul" {' >> vault.hcl
echo '  address = "consul:8500"' >> vault.hcl
echo '  advertise_addr = "consul:8300"' >> vault.hcl
echo '  scheme = "http"' >> vault.hcl
echo '}' >> vault.hcl
echo 'listener "tcp" {' >> vault.hcl
echo '  address = "0.0.0.0:8200"' >> vault.hcl
echo '  tls_disable = 1' >> vault.hcl
echo '}' >> vault.hcl
echo 'disable_mlock = true' >> vault.hcl

echo 'docker create -v /config --name config busybox; docker cp vault.hcl config:/config/ ;' >> start-vault.sh
echo 'docker run -d --name consul -p 8500:8500 consul:v0.6.4 agent -dev -client=0.0.0.0 ;' >> start-vault.sh
echo 'docker run -d --name vault-dev --link consul:consul -p 8200:8200 --volumes-from config cgswong/vault:0.5.3 server -config=/config/vault.hcl ;' >> start-vault.sh


echo "alias vault='docker exec -it vault-dev vault ""$@""'" >> .profile
echo "alias ll='ls -la'" >> .profile
echo "export VAULT_ADDR=http://127.0.0.1:8200" >> .profile

docker pull busybox
docker pull consul:v0.6.4
docker pull cgswong/vault:0.5.3


