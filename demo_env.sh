# If you are manually creating the infrastructure, set 
# the following DB_ variables to point at your MySQL database
export DB_USERNAME="<admin username>"
export DB_PASSWORD="<admin user password>"
export DB_HOSTNAME="<database hostname>"
export DB_PORT="<database port>"

# The following variables are set to use the Vault dev
# instance in the demo
export VAULT_ADDR=http://127.0.0.1:8200
export VAULT_ROOT_TOKEN=vault-root-token
