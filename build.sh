terraform apply -auto-approve &&  \
ansible-playbook \
  ./ansible/azure_ipsec.yaml \
  --extra-vars "$(terraform output --json | jq 'with_entries(.value |= .value)')" && \
ansible-playbook -i $(terraform output -raw dns_forwarder_ip), \
  --extra-vars "$(terraform output --json | jq 'with_entries(.value |= .value)')" \
  ./ansible/azure_dns_forwarder.yaml
