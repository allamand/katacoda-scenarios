

echo "step1-verify.sh"

if [[ $(docker-compose -p test2 -f docker-compose-test2.yml ps | wc -l) -gt 5 ]]; then echo "done" ; fi
