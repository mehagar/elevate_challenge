# Elevate Challenge

## Requirements

[RVM](https://rvm.io/rvm/install/) (ruby version manager) lets us switch between ruby interpreters and isolate gem
installations.

1. Install rvm
1. `cd` to the directory this repository is in.   
1. Install ruby via `rvm install $(cat .ruby-version)`.
1. `gem install bundler`
1. `bundle install`

## Running the app

1. `bin/rails server`
1. The rails server should now be running and accepting requests. For example, to create a new user:
`curl -d '{"email":"test@email.com", "username": "test_username", "password":"test_password", "fullname": "Michael Hagar" }' -H "Content-Type: application/json" -X POST http://localhost:3000/api/user`

## Running tests

1. `bin/rspec`
