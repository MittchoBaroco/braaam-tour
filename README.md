# README

## TODO:
* get rails credentil key
* create .rbenv-vars file with key
* validations for the Tour image (present and file types)
* configure amazon uploads for production - in credentials enc
* figure how to pass scss varaibles to components

## Start your development servers

* getting started
```bash
bundle install
yarn install
bin/rails db:create
bin/rails db:migrate
bundle exec rails webpacker:binstubs
rails c
Manager.create(:email => "user@name.com", :full_name => "Bill", :password => 'password', :password_confirmation => 'password')
exit
# now start the service using:
foreman start -f Procfile.dev
# or one of the other below services to start up
```

* with Forman
```
foreman start -f Procfile.dev
```
* with hivemind
```
hivemind Procfile.dev
```

* with Overmind
```
overmind start -f Procfile.dev
```

# production
## heroku
please set master key in RAILS_MASTER_KEY env var as explain in config/environment/production.yml line 19

## Versions
rails 5.2.0.rc1
ruby 2.5.0

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
