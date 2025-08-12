# Lillia Platform API

[![ci](https://github.com/deolivtiago/lillia-api/actions/workflows/ci.yml/badge.svg)](https://github.com/deolivtiago/lillia-api/actions/workflows/ci.yml)
[![coverage](https://coveralls.io/repos/github/deolivtiago/lillia-api/badge.svg)](https://coveralls.io/github/deolivtiago/lillia-api)

## Setup

Requirements:

- `docker-compose 2.39`
- `elixir 1.18`
- `erlang 28.0`

### Getting started

To start your Phoenix server:

* Rename the `.env.example` file to `.env` and set the environment variables
* Run services with `docker-compose up -d`
* Install dependencies with `mix deps.get`
* Setup database with `mix ecto.setup`
* Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
