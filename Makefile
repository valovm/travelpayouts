build:
	docker-compose build

start:
	docker-compose up

migrate:
	docker-compose run core rake db:migrate

install:
	git clone git@github.com:valovm/travelpayouts.git ./core
	make build
	docker-compose run core rake db:create
	make migrate
