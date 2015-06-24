require 'redis'

REDIS = Redis.new(url: ENV['REDIS_URL'])
