#!/bin/bash



install() {
  COMMAND=${1}
  VALUES_PATH=${2}
  NAME=${3}
  NAMESPACE=${4}
  helm ${COMMAND} \
    --namespace "${NAMESPACE}" \
    --repo https://bokysan.github.io/docker-postfix/ \
    --set config.general.RELAYHOST="${RELAYHOST}" \
    --set config.general.RELAYHOST_PASSWORD="${RELAYHOST_PASSWORD}" \
    --set config.general.RELAYHOST_USERNAME="${RELAYHOST_USERNAME}" \
    --values ./values-full.yaml \
    --values "${VALUES_PATH}" \
    "${NAME}" \
    mail
}

# Print usage
usage() {
  echo "Usage:"
  echo "    ./install.sh [-hty] [-f <values path>] [-n <release name>] [-s <namespace>]"
  echo "Options:"
  echo "    -h - Print this help"
  echo "    -t - Print templated manifests. Only if NOT -y"
  echo "    -y - Actually run"
  echo "    -f <values path> - Set path to values.yaml"
  echo "        Default: ./values.yaml"
  echo "    -n <release name> - Set release name"
  echo "        Default: postfix"
  echo "    -s <namespace> - Set the namespace"
  echo "        Default: default"
}

if [ -z "${RELAYHOST}" ] || [ -z "${RELAYHOST_PASSWORD}" ] || [ -z "${RELAYHOST_USERNAME}" ]; then
  echo "Please set RELAYHOST, RELAYHOST_USERNAME, and RELAYHOST_PASSWORD in your env"
  exit 1
fi



# Script
VALUES_PATH=""
NAME=""
NAMESPACE=""
RUN=""
TEMPLATE=""
while getopts f:hn:s:ty OPT; do
  case "$OPT" in
    f)
      VALUES_PATH=$OPTARG
    ;;
    h)
      usage
      exit 0
    ;;
    n)
      NAME=$OPTARG
    ;;
    s)
      NAMESPACE=$OPTARG
    ;;
    t)
      TEMPLATE="yes"
    ;;
    y)
      RUN="yes"
    ;;
    [?])
      usage
      exit 1
    ;;
  esac
done

# Set default release name
if [[ -z ${NAME} ]]; then
  NAME="postfix"
  echo "Using default name: ${NAME}"
fi

# Set default namespace
if [[ -z ${NAMESPACE} ]]; then
  NAMESPACE="default"
  echo "Using default namespace: ${NAMESPACE}"
fi

# Set default values.yaml path
if [[ -z ${VALUES_PATH} ]]; then
  VALUES_PATH="./values.yaml"
  echo "Usign default values: ${VALUES_PATH}"
fi

# Don't run if -y isn't provided
if [[ -z ${RUN} ]]; then
  echo "Dry Run - Templating. Pass -y to run."
  if [[ -n ${TEMPLATE} ]]; then
    install "template" "${VALUES_PATH}" "${NAME}" "${NAMESPACE}"
  else
    usage
  fi
else
  install "upgrade --install" "${VALUES_PATH}" "${NAME}" "${NAMESPACE}"
fi
