REDIS = Redis::Namespace.new('instabug', redis: Redis.new(host: ENV['REDIS_HOST']))
