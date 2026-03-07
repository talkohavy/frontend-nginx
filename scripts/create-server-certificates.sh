cd /Users/tal.kohavy/Desktop/dailyUse/1_GitHub_Projects/frontend-nginx/

mkdir -p certs/server

cd certs/server

# 1. Create CA key + self-signed CA cert
openssl genrsa -out server-ca.key 2048
openssl req -new -x509 -days 825 -key server-ca.key \
	-subj "/CN=MyServerCA" \
	-out server-ca.crt

# 2. Create server key + CSR
openssl genrsa -out server-private-key.pem 2048
openssl req -new -key server-private-key.pem \
	-subj "/CN=localhost" \
	-out server.csr

# 3. Create an ext file with the SAN — this is the critical part
cat >san.ext <<EOF
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage=digitalSignature,keyEncipherment
extendedKeyUsage=serverAuth
subjectAltName=DNS:localhost
EOF

# 4. Sign the cert with the CA, including the SAN extension
openssl x509 -req -days 825 \
	-in server.csr \
	-CA server-ca.crt -CAkey server-ca.key -CAcreateserial \
	-extfile san.ext \
	-out fullchain.pem

# 5. Clean up temp files
rm server.csr san.ext server-ca.srl
