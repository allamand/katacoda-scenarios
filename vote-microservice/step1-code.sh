echo "step1-code"

#cat <<EOF > docker-compose.yml
#traefik:
#  image: traefik
#  command: --web --docker --docker.domain=docker.localhost --logLevel=DEBUG
#  ports:
#    - "80:80"
#    - "8080:8080"
#    - "443:443"
#  volumes:
#    - /var/run/docker.sock:/var/run/docker.sock
#    - /dev/null:/traefik.toml
#EOF


#echo "https://[[CLIENT_SUBDOMAIN]]-8080-[[KATACODA_HOST]].environments.katacoda.com"

export CLIENT_SUBDOMAIN=[[CLIENT_SUBDOMAIN]]
export KATACODA_HOST=[[KATACODA_HOST]]
