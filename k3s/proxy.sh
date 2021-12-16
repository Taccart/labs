#! /bin/bash
RED='\033[1;31m'
YEL='\033[1;33m'
CYAN='\033[1;36m'
NC='\033[0m' # No Color

APISERVER=$(k3s kubectl config view --minify | grep server | cut -f 2- -d ":" | tr -d " ")
SECRET_NAME=$(k3s kubectl get secrets | grep ^admin | cut -f1 -d ' ')
TOKEN=$(k3s kubectl describe secret $SECRET_NAME | grep -E '^token' | cut -f2 -d':' | tr -d " ")
echo "API"

curl $APISERVER/api --header "Authorization: Bearer $TOKEN" --insecure

echo "TOKEN -----"
printf "\n${CYAN}$TOKEN\n${NC}"
echo "-----"
echo "Dashboard URL : "
printf "${YEL}https://127.0.0.1:8443${NC}\n\n"
k3s kubectl port-forward --address 0.0.0.0 service/kubernetes-dashboard -n kubernetes-dashboard 8443:8443
