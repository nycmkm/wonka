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
