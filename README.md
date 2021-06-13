# Masterpiece

[![Elixir CI](https://github.com/awwar/masterpiece/actions/workflows/elixir.yml/badge.svg)](https://github.com/awwar/masterpiece/actions/workflows/elixir.yml)
![stability-experimental](https://img.shields.io/badge/stability-experimental-orange.svg)

***WORK IN PROGRESS!!! Do not ready for production usage!!!***

Masterpiece is "no code" solution for a web server.

## Installation

1. Clone this repo
2. Install elixir on your pc [(installation guide)](https://elixir-lang.org/install.html)
3. Run `mix deps.get` to get web server dependency's
4. Create a configuration ([./test.json](https://raw.githubusercontent.com/awwar/masterpiece/main/test.json), as example ) 
5. Run `mix mtp.compile --config <path to json config>`
6. Run `mix run --no-halt` to start web server
