.PHONY: help init build start stop down rebuild restart status login

DOCKER_EXEC = docker-compose exec

help:
	@echo "Docker util:"
	@echo "  make init              Initialize docker containers."
	@echo "  make build             Build the docker containers."
	@echo "  make rebuild           Rebuild the docker containers."
	@echo "  make start             Start the docker containers."
	@echo "  make stop              Stop the docker containers."
	@echo "  make down              Down the docker containers."
	@echo "  make restart           Restart the docker containers."
	@echo "  make status            Show containers"
	@echo
	@echo "Container:"
	@echo "  make login             login pipenv container."

init: build start

build:
	@cp ~/.ssh/id_rsa_for_github docker/
	@cp ./Gemfile* ./.pryrc docker/
	@cd ./docker && docker build --tag coocre_backend:3.0 .
	@rm -f docker/id_rsa_for_github docker/Gemfile* docker/.pryrc
	@docker-compose build

start:
	@TMPDIR=${TMPDIR} docker-compose up -d

dev-start:
	@TMPDIR=${TMPDIR} docker-compose up

db-init:
	@$(DOCKER_EXEC) api bundle exec rails db:drop db:create db:schema:load db:migrate db:seed_fu

stop:
	@docker-compose stop

down:
	@docker-compose down

rebuild: down build

restart: stop start

status:
	@docker-compose ps

attach:
	@docker attach coocre_backend --detach-keys="ctrl-d"

login:
	@$(DOCKER_EXEC) api /bin/zsh
