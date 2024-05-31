NAME        := inception
VOLUMES     := ./data
COMPOSE     := srcs/docker-compose.yml

MAKEFLAGS   += --no-print-directory

all: setup build up

# sets up necessary environment
setup:
	-if ! grep -q "$(NAME).fr" /etc/hosts; then echo "127.0.0.1 $(NAME).fr" | sudo tee -a /etc/hosts; fi
	-mkdir -p $(VOLUMES)/wordpress
	-mkdir -p $(VOLUMES)/mariadb
	echo "[make] setup ok"

# build or update images
build:
	-docker compose --file $(COMPOSE) build && echo "[make] build ok"

# start and enable services
up:
	-docker compose --file $(COMPOSE) up --detach && echo "[make] up ok"

# pause services
stop:
	-docker compose --file $(COMPOSE) stop && echo "[make] stop ok"

# shutdown and remove services
down:
	-docker compose --file $(COMPOSE) down && echo "[make] down ok"

# launches cloud infra
launch_cloud:
	-cd terraform/ ; terraform apply -auto-approve ; terraform output public_ip1 >../ansible/hosts ; terraform output public_ip2 >>../ansible/hosts
	-cd ansible/ ; ansible-playbook -i hosts install.yaml

destroy_cloud:
	-cd terraform/ ; terraform  apply -destroy -auto-approve

# remove docker containers, networks and volumes
clean:
	-docker compose --file $(COMPOSE) down --volumes --remove-orphans && echo "[make] clean ok"

# remove all generated files and modifications !!! like volumes data !!!
fclean:
	$(MAKE) clean
	-sudo rm -rf $(VOLUMES)
	-sudo sed -i '/$(NAME)/d' /etc/hosts
	echo "[make] fclean ok"

# rebuild app from scratch
re:
	$(MAKE) clean
	$(MAKE) all
	echo "[make] re ok"

.PHONY: setup build up stop down clean fclean re
.SILENT:
