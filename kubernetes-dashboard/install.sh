helm upgrade \
  --create-namespace \
  --install \
  --namespace kubernetes-dashboard \
  --repo https://kubernetes.github.io/dashboard/ \
  --values values.yaml \
  kubernetes-dashboard \
  kubernetes-dashboard

# helm upgrade --install kubernetes-dashboard kubernetes-dashboard/kubernetes-dashboard --create-namespace --namespace kubernetes-dashboard
