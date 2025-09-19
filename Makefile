all: launch_cloud

# launches cloud infra
launch_cloud:
	-cd terraform/ ; terraform init; source ../.env && terraform apply -auto-approve; terraform output public_ip1 >../ansible/hosts; terraform output public_ip2 >>../ansible/hosts
	-cd ansible/ ; ansible-playbook -i hosts install.yaml
	-cd terraform/ ; terraform output lb_ip >../ansible/hosts
	-cd ansible/ ; ansible-playbook -i hosts duckdns.yaml


destroy_cloud:
	-cd terraform/ ; terraform apply -destroy -auto-approve; rm -rf .terraform.d/plugin-cache/*terraform ; rm .terraform.lock.hcl
