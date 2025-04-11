#!/bin/bash

usage() {
  echo "S3_ADMIN_AWS_ACCESS_KEY_ID=${S3_ADMIN_AWS_ACCESS_KEY_ID}
  S3_ADMIN_AWS_SECRET_ACCESS_KEY=${S3_ADMIN_AWS_SECRET_ACCESS_KEY}
  CORE_KEEPER_DISCORD_HOOK=${CORE_KEEPER_DISCORD_HOOK}"
}

RELEASE_NAME="core1"

if [[ "${S3_ADMIN_AWS_ACCESS_KEY_ID}" == "" ]] \
  || [[ "${S3_ADMIN_AWS_SECRET_ACCESS_KEY}" == "" ]] \
  || [[ "${CORE_KEEPER_DISCORD_HOOK}" == "" ]]
then
  usage
  exit 1
fi

helm upgrade \
  --install \
  --set "aws_access_key_id=${S3_ADMIN_AWS_ACCESS_KEY_ID}" \
  --set "aws_secret_access_key=${S3_ADMIN_AWS_SECRET_ACCESS_KEY}" \
  --set "discord_hook=${CORE_KEEPER_DISCORD_HOOK}" \
  --values ./values.yaml \
  ${RELEASE_NAME} \
  .
