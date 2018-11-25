# README

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
then edit credentials files and set correct AWS S3 bucket for pictures

## Versions
rails 5.2.0.rc1
ruby 2.5.0