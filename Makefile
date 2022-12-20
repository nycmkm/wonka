build:
	docker-compose build

console: build
	docker-compose run web /bin/bash

dev: build
	docker-compose run web rake db:create db:migrate
	docker-compose up

test: build
	docker-compose run web rake db:create db:migrate RAILS_ENV=test
	docker-compose run web rspec
