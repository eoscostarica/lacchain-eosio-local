-include .env

ifneq ("$(wildcard .env)", "")
	export $(shell sed 's/=.*//' .env)
endif

run: ##@local Run the project locally
run:
	@docker-compose stop
	@docker-compose up -d --build
	@docker-compose logs -f

clone-repo:
	@if ! [ -d $(CHECKDIR) ]; then \
		echo "Cloning repository"; \
		git clone $(REPOSITORY); \
	fi