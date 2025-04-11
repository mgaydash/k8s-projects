#!/bin/bash

# Functions
usage() {
  echo "Usage:"
  echo "    install.sh <release name>"
}

# Script
RELEASE_NAME=cert-manager

if [[ -z ${RELEASE_NAME} ]]; then
  usage
  exit 1
fi

helm upgrade --install \
  --create-namespace \
  --namespace cert-manager \
  --repo https://charts.jetstack.io \
  --set installCRDs=true \
  --version v1.13.2 \
  ${RELEASE_NAME} \
  cert-manager

kubectl create -k .
