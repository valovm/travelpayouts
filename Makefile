build:
	docker-compose build

start:
	docker-compose up --force-recreate -d
stop:
	docker-compose down

restart: stop start

ps:
	docker-compose ps

migrate:
	docker-compose exec core rake db:migrate

install:
	git clone git@github.com:valovm/travelpayouts.git ./core
	make build
