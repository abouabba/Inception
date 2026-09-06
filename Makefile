NAME = inception

COMPOSE = docker compose -f srcs/docker-compose.yml

all: up

up:
	@mkdir -p /home/abouabba/data/wordpress
	@mkdir -p /home/abouabba/data/mariadb
	$(COMPOSE) up --build -d

down:
	$(COMPOSE) down

clean:
	$(COMPOSE) down -v

re: clean up

.PHONY: all up down clean re
 