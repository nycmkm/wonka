build:
	docker-compose build

console: build
	docker-compose run web /bin/bash

deploy:
	fly deploy --build-arg GIT_COMMIT=$(git rev-parse HEAD)

dev: build
	docker-compose run web rake db:create db:migrate
	docker-compose up

test: build
	docker-compose run web rake db:create db:migrate RAILS_ENV=test
	docker-compose run web rspec
