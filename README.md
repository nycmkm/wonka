# wonka

Run giveaways from the set of attendees checked in for an Eventbrite event

## Local Setup

1. Create a `.env` file with the following keys:
  ```
  EVENTBRITE_ORGANIZATION_ID=
  EVENTBRITE_API_KEY=
  ```
1. `make dev`
1. In a rails console, make a user with `User.create!(email: <EMAIL>, password: <password>)`

## Running tests

`make test`

## Running linters

Rubocop and Brakeman are run automatically by GitHub Actions. If you want to run them locally, you can run

`make lint`

[![Coverage Status](https://coveralls.io/repos/github/nycmkm/wonka/badge.svg)](https://coveralls.io/github/nycmkm/wonka)