#!/bin/bash

# Functions
usage() {
  echo "Usage:"
  echo "    install.sh <release name>"
}

# Script
RELEASE_NAME=ingress-nginx

if [[ "${RELEASE_NAME}" == "" ]]; then
  usage
  exit 1
fi

helm upgrade \
  --create-namespace \
  --install \
  --namespace ingress-nginx \
  --repo https://kubernetes.github.io/ingress-nginx \
  --values ./values.yaml \
  ${RELEASE_NAME} \
  ingress-nginx
