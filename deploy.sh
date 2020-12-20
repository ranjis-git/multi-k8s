docker build -t ranjidocker/multi-client:latest -t ranjidocker/multi-client:$SHA -f ./client/Dockerfile ./client  
docker build -t ranjidocker/multi-server:latest -t ranjidocker/multi-server:$SHA -f ./server/Dockerfile ./server  
docker build -t ranjidocker/multi-worker:latest -t ranjidocker/multi-worker:$SHA -f ./worker/Dockerfile ./worker  
docker push ranjidocker/multi-client:latest
docker push ranjidocker/multi-server:latest
docker push ranjidocker/multi-worker:latest
docker push ranjidocker/multi-client:$SHA
docker push ranjidocker/multi-server:$SHA
docker push ranjidocker/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/client-deployment client=ranjidocker/multi-client:$SHA
kubectl set image deployments/server-deployment server=ranjidocker/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=ranjidocker/multi-worker:$SHA