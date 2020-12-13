docker build -t dimajedi/complex-client:latest -t dimajedi/complex-client:$SHA -f ./client/Dockerfile ./client
docker build -t dimajedi/complex-server:latest -t dimajedi/complex-server:$SHA -f ./server/Dockerfile ./server
docker build -t dimajedi/complex-worker:latest -t dimajedi/complex-worker:$SHA -f ./worker/Dockerfile ./worker

docker push dimajedi/complex-client:latest
docker push dimajedi/complex-server:latest
docker push dimajedi/complex-worker:latest

docker push stephengrider/multi-client:$SHA
docker push stephengrider/multi-server:$SHA
docker push stephengrider/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=dimajedi/complex-client:$SHA
kubectl set image deployments/server-deployment server=dimajedi/complex-server:$SHA
kubectl set image deployments/worker-deployment worker=dimajedi/complex-worker:$SHA
