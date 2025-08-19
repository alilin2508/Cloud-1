all: launch_cloud

# launches cloud infra
launch_cloud:
	-cd terraform/ ; terraform init; terraform apply -auto-approve ; terraform output public_ip1 >../ansible/hosts
	-cd ansible/ ; ansible-playbook -i hosts install.yaml
	-sed -i 's/^DOMAIN_NAME=.*/DOMAIN_NAME=inceptionalice2.duckdns.org/' .env
	-cd terraform/ ; terraform output public_ip2 >../ansible/hosts
	-cd ansible/ ; ansible-playbook -i hosts install.yaml

destroy_cloud:
	-cd terraform/ ; terraform apply -destroy -auto-approve; rm -rf .terraform.d/plugin-cache/*terraform ; rm .terraform.lock.hcl
