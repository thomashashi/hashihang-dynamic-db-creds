#!/bin/sh

PATH=`pwd`/bin:$PATH

if [ demo_env.sh ]; then
    . ./demo_env.sh
fi

nohup vault server -dev -dev-root-token-id=${VAULT_ROOT_TOKEN} > vault.log 2>&1 &
echo $! > vault.pid

echo "Vault started, pid in 'vault.pid', log in 'vault.log'"
