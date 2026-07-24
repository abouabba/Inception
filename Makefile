NAME = inception

COMPOSE = sudo docker compose -f srcs/docker-compose.yml

all: up

up:
	@mkdir -p /home/abouabba/data/wordpress
	@mkdir -p /home/abouabba/data/mariadb
	$(COMPOSE) up --build

down:
	$(COMPOSE) down

clean:
	$(COMPOSE) down -v

re: clean up

.PHONY: all up down clean re
