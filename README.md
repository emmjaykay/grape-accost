# grape-accost

## Getting started

First, run the DB migrations

    bundle exec rake db:migrate

Make a directory called .env in the parent directory. 
Create a symbolic link to that directory called 'env'

    mkdir ../env
    ln -s ../env env

Create two files in that directory called '.env.development' and '.env.test'. These will contain
the environments depending if you are developing or running tests.

Finally, add whatever environment variables you need to each of those files. Right now, you
need DATABASE_URL defined. For example in the development file, I have

    DATABASE_URL='sqlite://db-development.sqlite'

and in test

    DATABASE_URL='sqlite://db-test.sqlite'

Start sidekiq from the project's root directory with

    bundle exec sidekiq -r `pwd`/config/sidekiq.rb -v

## API 

### Create an Activity Object

    curl -H "Content-Type: application/json" localhost:9292/api/create -X POST --data '{ "actor_uuid":"jon", "verb":"create", "object_uuid":"comment", "target_uuid":"a post"}'

### Get a user's Feed

    curl localhost:9292/api/feed/jon | jq '.[]'

### Subscribe to another user's feed. In this case, 'stannis' is going to follow 'jon'.

    curl -H "Content-Type: application/json" localhost:9292/api/subscribe/stannis --data '{ "topic_uuid":"jon"}'


#### TODO
  * REDIS integration
  * Integration Activity Stream 2.0 objects, and associated services
  * authentication
  * security items
    * bcrypt
    * DoS attack prevention
  * Find a way to recover feeds that are missing activities

[.](http://mjk.freeshell.org/accost.gif)
