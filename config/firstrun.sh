#!/usr/bin/env bash
set -e

FQDN="$1"
MELLON_ENDPOINT_URL="https://${FQDN}/saml"
MELLON_ENTITY_ID="${MELLON_ENDPOINT_URL}/metadata"

/opt/mellon_create_metadata.sh $MELLON_ENTITY_ID $MELLON_ENDPOINT_URL

mv *metadata.cert /etc/apache2/saml/metadata.cert
mv *metadata.key /etc/apache2/saml/metadata.key
mv *metadata.xml /etc/apache2/saml/metadata.xml
