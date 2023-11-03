#!/usr/bin/env bash

echo "Downloading istio into system"...

curl -L https://istio.io/downloadIstio | ISTIO_VERSION=1.19.0 TARGET_ARCH=x86_64 sh -

cp istio-operator.yaml ./istio-1.19.0/

cd ./istio-1.19.0/

export PATH=$PWD/bin:$PATH

./bin/istioctl install -f ./istio-operator.yaml

kubectl create -f samples/addons/kiali.yaml
kubectl create -f samples/addons/prometheus.yaml
kubectl create -f samples/addons/grafana.yaml
