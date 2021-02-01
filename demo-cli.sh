az acr login --name nzaksacr

az acr list --resource-group nzaplaksautoscale --query "[].{acrLoginServer:loginServer}" --output table

docker images

docker tag mcr.microsoft.com/azuredocs/azure-vote-front:v1 nzaksacr.azurecr.io/azure-vote-front:v1

docker push  nzaksacr.azurecr.io/azure-vote-front:v1

az acr repository list --name nzaksacr --output table

az aks create \
    --resource-group nzaplaksautoscale \
    --name nzaplaks \
    --node-count 2 \
    --generate-ssh-keys \
    --attach-acr nzaksacr

az aks get-credentials --resource-group nzaplaksautoscale --name nzaplaks

az aks show --resource-group nzaplaksautoscale --name nzaplaks --query kubernetesVersion --output table

kubectl get pods

kubectl scale --replicas=3 deployment/azure-vote-front


kubectl apply -f load-test.yaml 

kubectl autoscale deployment azure-vote-front --cpu-percent=50 --min=3 --max=10

kubectl apply -f https://k8s.io/examples/application/php-apache.yaml

kubectl autoscale deployment php-apache --cpu-percent=50 --min=1 --max=100

kubectl get hpa

kubectl describe hpa

kubectl apply -f load-test.yaml

kubectl scale --replicas=8 deployment/php-apache

kubectl run -i --tty load-generator --image=busybox /bin/sh

az aks update \
    --resource-group nzaplaksautoscale \
    --name nzaplaks \
  --enable-cluster-autoscaler \
  --min-count 1 \
  --max-count 3

az aks update \
    --resource-group nzaplaksautoscale \
    --name nzaplaks \
  --update-cluster-autoscaler \
  --min-count 1 \
  --max-count 5

# Setup Work Tool
sudo apt-get install build-essential libssl-dev git -y
git clone https://github.com/wg/wrk.git wrk
cd wrk
sudo make

wrk -t12 -c400 -d30s --latency http://20.45.2.144

https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale-walkthrough/

watch -n 5 kubectl get pods

https://searchitoperations.techtarget.com/tutorial/Kubernetes-performance-testing-tutorial-Load-test-a-cluster

wrk$ wrk -t24 -c400 -d120s --latency http://52.153.113.183