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
    REDIS_URL='redis://localhost:6379/dev'

and in test

    DATABASE_URL='sqlite://db-test.sqlite'
    REDIS_URL='redis://localhost:6379/test'

Start sidekiq from the project's root directory with

    bundle exec sidekiq -r `pwd`/config/sidekiq.rb -v

## API 

### Create an Activity Object

    curl -H "Content-Type: application/json" localhost:9292/api/create -X POST --data '{ "actor_uuid":"jon", "verb":"create", "object_uuid":"comment", "target_uuid":"a post"}'

### Get a user's Feed

    curl localhost:9292/api/feed/jon | jq '.[]'

### Subscribe to another user's feed. In this case, 'stannis' is going to follow 'jon'.

    curl -H "Content-Type: application/json" localhost:9292/api/subscribe/stannis --data '{ "topic_uuid":"jon"}'

### Unsubscribe to another user's feed

    curl -H "Content-Type: application/json" localhost:9292/api/unsubscribe/stannis --data '{ "topic_uuid":"jon"}' 

## Architecture

An activity can be phrased as

    <actor> <verb'd> <target object> <optional collection object>

So, for example,

    <jon> <created> <a comment object> <in a post object>

Each activity is then stored into the DB and can be put into a feed, or list of objects for later retrieval. Upon 
Activity creation a pub-sub system kicks off a thread (wisper gem) that creates an ActivityFeed object that is really 
a string of primary keys to Activity objects. 

A presenter is called up to store the feed into a Redis DB. The feed is retrieved from there for quick lookup.

#### TODO
  * Integration Activity Stream 2.0 objects, and associated services
  * authentication
  * security items
    * bcrypt
    * DoS attack prevention
  * Find a way to recover feeds that are missing activities

[.](http://mjk.freeshell.org/accost-2014Jul2.gif)
[![ghit.me](https://ghit.me/badge.svg?repo=emmjaykay/grape-accost)](https://ghit.me/repo/emmjaykay/grape-accost)
