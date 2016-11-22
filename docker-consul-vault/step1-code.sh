#!/bin/bash

echo -e "\u001b[34m Environment Setup.. \u001b[m"

cat <<'EOF' > unseal-vault.sh
export VAULT_ADDR=http://127.0.0.1:8200
if [ ! -f keys.txt ]; then
  docker exec -it vault-dev vault init -address=${VAULT_ADDR} > keys.txt
fi
docker exec -it vault-dev vault status -address=${VAULT_ADDR} || true
echo -e "\u001b[34m Unseal Vault \u001b[m"
docker exec -it vault-dev vault unseal -address=${VAULT_ADDR} $(grep 'Key 1:' keys.txt | awk '{print $NF}')
docker exec -it vault-dev vault unseal -address=${VAULT_ADDR} $(grep 'Key 2:' keys.txt | awk '{print $NF}')
docker exec -it vault-dev vault unseal -address=${VAULT_ADDR} $(grep 'Key 3:' keys.txt | awk '{print $NF}')
EOF
chmod 755 unseal-vault.sh
chmod 755 start-vault.sh

source .profile



clear

echo -e "\u001b[34m Your environment is Setup!! \u001b[m"

