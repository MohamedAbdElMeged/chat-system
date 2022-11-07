# Redis Service
class RedisService
  def initialize
    @redis = REDIS
  end

  def save_in_redis(key, value)
    @redis.set(key, value)
  end

  def get_from_redis(key)
    @redis.get(key)
  end

  def save_hash_in_redis(hash, key, value)
    @redis.hset(hash, key, value)
  end

  def get_hash_value_by_key(hash, key)
    @redis.hget(hash, key)
  end

  def increment_counter(key)
    @redis.incr(key)
  end
end
