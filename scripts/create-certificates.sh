cd /Users/tal.kohavy/Desktop/dailyUse/1_GitHub_Projects/frontend-nginx/certs

# 1. Create CA key + self-signed CA cert
openssl genrsa -out ca.key 2048
openssl req -new -x509 -days 825 -key ca.key \
	-subj "/CN=MyCA" \
	-out ca.crt

# 2. Create server key + CSR
openssl genrsa -out privkey.pem 2048
openssl req -new -key privkey.pem \
	-subj "/CN=luckylove.co.il" \
	-out server.csr

# 3. Create an ext file with the SAN — this is the critical part
cat >san.ext <<EOF
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage=digitalSignature,keyEncipherment
extendedKeyUsage=serverAuth
subjectAltName=DNS:luckylove.co.il
EOF

# 4. Sign the cert with the CA, including the SAN extension
openssl x509 -req -days 825 \
	-in server.csr \
	-CA ca.crt -CAkey ca.key -CAcreateserial \
	-extfile san.ext \
	-out fullchain.pem

# 5. Clean up temp files
rm server.csr san.ext ca.srl
