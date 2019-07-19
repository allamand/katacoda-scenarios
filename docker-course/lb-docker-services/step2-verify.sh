

echo "step1-verify.sh"

if [[ $(docker-compose -p test2 -f docker-compose-test2.yml ps | wc -l) -le 5 ]]; then echo "not enough" ; fi
