terraform destroy -auto-approve &&  \
ansible-playbook \
  ./ansible/azure_ipsec_remove.yaml \
  --extra-vars "$(terraform output --json | jq 'with_entries(.value |= .value)')" 
