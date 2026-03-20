mkdir -p certs
cd ./certs

# 1. Create CA key + self-signed CA cert
openssl genrsa -out my-nginx-proxy-ca.key 2048
openssl req -new -x509 -days 825 -key my-nginx-proxy-ca.key \
	-subj "/CN=MyNginxProxyCA" \
	-out my-nginx-proxy-ca.crt

# 2. Create server key + CSR
openssl genrsa -out my-nginx-proxy-server.key 2048
openssl req -new -key my-nginx-proxy-server.key \
	-subj "/CN=luckylove.co.il" \
	-out my-nginx-proxy-server.csr

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
	-in my-nginx-proxy-server.csr \
	-CA my-nginx-proxy-ca.crt -CAkey my-nginx-proxy-ca.key -CAcreateserial \
	-extfile san.ext \
	-out fullchain.pem

# 5. Clean up temp files
rm my-nginx-proxy-server.csr san.ext my-nginx-proxy-ca.srl
