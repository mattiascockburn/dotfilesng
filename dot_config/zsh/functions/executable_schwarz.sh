schwarz_proxy() {
  export HTTPS_PROXY=http://192.168.122.97:3128
  export HTTP_PROXY=$HTTPS_PROXY
  export REQUESTS_CA_BUNDLE="${HOME}/schwarz/ca/cabundle.pem"
  export SSL_CERT_FILE="$REQUESTS_CA_BUNDLE"
}
