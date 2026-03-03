#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CERT_DIR="${SCRIPT_DIR}/../certs"

mkdir -p "$CERT_DIR"

openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-keyout "${CERT_DIR}/privkey.pem" \
	-out "${CERT_DIR}/fullchain.pem" \
	-subj "/CN=localhost"

echo "Created ${CERT_DIR}/fullchain.pem and ${CERT_DIR}/privkey.pem (valid 365 days, for localhost)"
