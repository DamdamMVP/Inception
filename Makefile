COMPOSE_FILE = srcs/docker-compose.yml

NAME = inception

DC = docker-compose
DOWN = down
UP = up
BUILD = --build


all: $(NAME)

$(NAME):
	$(DC) -f $(COMPOSE_FILE) up -d --build

up:
	$(DC) -f $(COMPOSE_FILE) up -d

down:
	$(DC) -f $(COMPOSE_FILE) down

clean: 
	$(DC) -f $(COMPOSE_FILE) down -v

fclean: clean
	# Supprimer les images éventuellement
	docker rmi $$(docker images -q srcs_mariadb) 2>/dev/null || true
	docker rmi $$(docker images -q srcs_wordpress) 2>/dev/null || true
	docker rmi $$(docker images -q srcs_nginx) 2>/dev/null || true

re: fclean all

.PHONY: all up down clean fclean re

