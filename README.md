Create a Scaleway account, install and configure your Scaleway CLI.  Create a
project on your Scaleway account, fetch your project ID and put it in the
`project_id` field in `terraform/main.tf`.  Add your SSH public key to your
project.

```
  $ git clone https://github.com/alilin2508/Cloud-1
  $ cd Cloud-1
  $ mv env .env
```  
Then:
```
  $ cd terraform
  $ terraform apply -auto-approve
  $ terraform output public_ip1 >../ansible/hosts
  $ terraform output public_ip2 >>../ansible/hosts
  $ cd ../ansible
```

Bind your instance IP address to a domain name (free ones on duckdns.org) and
update the .env `DOMAIN_NAME` variable accordinly.

```
  $ ansible-playbook -i hosts install.yaml
```
Or simply:
```
  $ make launch_cloud
```

----------

  **Don't forget to** `$ terraform  apply -destroy -auto-approve` one done or `$ make destroy_cloud`
