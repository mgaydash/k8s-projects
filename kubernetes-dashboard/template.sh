helm template \
  --repo https://kubernetes.github.io/dashboard/ \
  --values values.yaml \
  kubernetes-dashboard \
  kubernetes-dashboard
