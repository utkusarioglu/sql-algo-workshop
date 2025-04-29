#!/bin/bash

su - <<EOF
ROOT

apt update 
apt install -y gcc
EOF

pip install -r requirements.txt

${HOME}/elam/elam.sh repo status
