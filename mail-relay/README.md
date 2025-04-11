# mail-relay



Install a private postfix mail relay into the cluster

## Scripts
- **install.sh** - Install the mail relay with Helm

## Helm
Artifact Hub: https://artifacthub.io/packages/helm/docker-postfix/mail

## Environment Vars
- RELAYHOST - URL of the mail server
- RELAYHOST_PASSWORD - Username for the server
- RELAYHOST_USERNAME - Server user's password
