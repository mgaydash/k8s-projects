#!/bin/bash

RELEASE=$1

if [[ -z ${RELEASE} ]]; then
  RELEASE=cert-manager
fi

kubectl delete -k .

helm uninstall \
  --namespace cert-manager \
  ${RELEASE}
