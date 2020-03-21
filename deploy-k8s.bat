REM Cean up previous env
kubectl delete -n default deployment lab-app-api
kubectl delete -n default deployment lab-app-proxy
kubectl delete -n default deployment lab-app-database
kubectl delete -n default service lab-app-api
kubectl delete -n default service lab-app-proxy
kubectl delete -n default service lab-app-database
kubectl delete -n default ingress lab-app-ingress

REM Enable minikube doker-env
FOR /f "tokens=*" %%i IN ('minikube -p minikube docker-env') DO @%%i

REM REM Build images 
docker build -t lab-app-api -f ./api/Dockerfile .
docker build -t lab-app-proxy -f ./proxy/Dockerfile .
docker build -t lab-app-database -f ./database/Dockerfile .

REM Apply app k8s configs
kubectl apply -f ./api/deployment/deployment.yaml
kubectl apply -f ./proxy/deployment/deployment.yaml
kubectl apply -f ./database/deployment/deployment.yaml

kubectl apply -f ./api/deployment/service.yaml
kubectl apply -f ./proxy/deployment/service.yaml
kubectl apply -f ./database/deployment/service.yaml

kubectl apply -f ./proxy/deployment/ingress.yaml
