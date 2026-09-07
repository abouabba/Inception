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

fclean:
	@sudo rm -rf /home/abouabba/data/wordpress home/abouabba/data/mariadb
	$(COMPOSE) down --rmi all -v
	docker system prune -af

re: clean up

.PHONY: all up down clean re
 