#!/bin/bash

if [[ "${NECESSE_PASSWORD}" == "" ]]; then
  echo "NECESSE_PASSWORD must be set" 
  exit 1
fi

helm upgrade \
  --install \
  --set "cfg.password=${NECESSE_PASSWORD}" \
  game-night-necesse \
  .
