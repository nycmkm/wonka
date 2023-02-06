GIT_VERSION := $(shell git rev-parse HEAD)

build:
	docker-compose build

console: build
	docker-compose run web /bin/bash

deploy:
	fly deploy --build-arg GIT_VERSION="$(GIT_VERSION)"

dev: build
	docker-compose run web rake db:create db:migrate
	docker-compose up

lint: build
	docker-compose run web rubocop
	docker-compose run web brakeman

test: build
	docker-compose run web rake db:create db:migrate RAILS_ENV=test
	docker-compose run web rspec
