#!/usr/bin/env bash
set -e

FQDN="$1"
MELLON_ENDPOINT_URL="https://${FQDN}/saml"
MELLON_ENTITY_ID="${MELLON_ENDPOINT_URL}/metadata"

/opt/mellon_create_metadata.sh $MELLON_ENTITY_ID $MELLON_ENDPOINT_URL

mv *metadata.cert /etc/apache2/saml/mellon.crt
echo mellon.crt
echo ""
cat /etc/apache2/saml/mellon.crt
echo ""
mv *metadata.key /etc/apache2/saml/mellon.key
echo mellon.key
echo ""
cat /etc/apache2/saml/mellon.key
echo ""
mv *metadata.xml /etc/apache2/saml/mellon_metadata.xml
echo mellon_metadata.xml
echo ""
cat /etc/apache2/saml/mellon_metadata.xml
