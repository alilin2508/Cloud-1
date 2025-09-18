DC := docker compose
DC_FLAGS := -f srcs/docker-compose.yml
VOLUMES := ./data
NAME := inceptionalice


all: setup build up

setup:
	-if ! grep -q "$(NAME).fr" /etc/hosts; then echo "127.0.0.1 $(NAME).fr" | sudo tee -a /etc/hosts; fi
	-mkdir -p $(VOLUMES)/wordpress
	-mkdir -p $(VOLUMES)/mysql

build:
	$(DC) $(DC_FLAGS) build

down:
	$(DC) $(DC_FLAGS) down -v

up:
	$(DC) $(DC_FLAGS) up -d

.PHONY: all build down up
