-include .env

ifneq ("$(wildcard .env)", "")
	export $(shell sed 's/=.*//' .env)
endif

run: ##@local Run the project locally
run:
	@docker-compose stop
	@docker-compose up -d --build
	@docker-compose logs -f

stop: ##@local Stops the development instance
stop:
	@docker-compose stop