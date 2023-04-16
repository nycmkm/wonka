# wonka

Run giveaways from the set of attendees checked in for an Eventbrite event

## Local Setup

1. Wonka runs locally using Docker and Docker Compose. Make sure Docker is installed and running.
1. Create a `.env` file with the following keys:
  ```
  EVENTBRITE_ORGANIZATION_ID=
  EVENTBRITE_API_KEY=
  ```
1. `make dev` will run database setup/migrations, spin up the necessary containers, and the application will be available at http://localhost:5000
1. In a rails console, make a user with `User.create!(email: <EMAIL>, password: <password>)`

## Accessing a shell

`make console` will bring up a bash prompt inside the web container. From there you can run `rails console` to access a console.

## Running tests

`make test`

## Running linters

Rubocop and Brakeman are run automatically by GitHub Actions. If you want to run them locally, you can run

`make lint`

[![Coverage Status](https://coveralls.io/repos/github/nycmkm/wonka/badge.svg)](https://coveralls.io/github/nycmkm/wonka)