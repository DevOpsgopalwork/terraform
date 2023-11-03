#!/usr/bin/env bash

# https://cloud.google.com/load-balancing/docs/https/
# https://cloud.google.com/solutions/integrating-https-load-balancing-with-istio-and-cloud-run-for-anthos-deployed-on-gke

cat <<EOF > istio-ingressgateway-patch.json
[
  {
    "op": "replace",
    "path": "/spec/type",
    "value": "NodePort"
  },
  {
    "op": "remove",
    "path": "/status"
  }
]
EOF

kubectl -n istio-system patch svc istio-ingressgateway \
    --type=json -p="$(cat istio-ingressgateway-patch.json)" \
    --dry-run=true -o yaml | kubectl apply -f -
