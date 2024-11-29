#!/bin/bash
KEY_FILE=${1:-key.pem}
terraform output private_key > "$KEY_FILE"
chmod 400 "$KEY_FILE"
