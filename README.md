
# Instabug Challenge

I applied at Instabug. I recently received this challenge to work on as part of the process.
Build a chat system. System has multiple Application identified by token, each Application has many chats identified by a number ( number should start from 1) , each Chat has many messages identified by a number ( number should start from 1)
- the endpoints should be RESTful
- Use MySQL as datastore
- use ElasticSearch for searching through messages of a specific chat
- use Docker to contatinerize the applicatio
- use RabbitMQ , Sneakers to avoid race conditions
- Personally I used `rufus-scheduler` to create a cron job to update chats_count and messages_count every 30 minutes

# How To Run The Challenge

We will only write this command to run the whole stack 
``` bash
docker-compose up
``` 

# My Approach
### Understand the requirements
- Extract classes (Application, Chat, Message)
- Define Relations between classes 


### Setup The Docker
- Add (RoR, MySQL, ElasticSearch , Redis , RabbitMQ, Sneakers, RufusScheduler) images
```docker-compose
version: '3.7'
services:
  es01:
    image: docker.elastic.co/elasticsearch/elasticsearch:7.16.3
    container_name: es01
    environment:
      - cluster.name=es-docker-cluster
      - bootstrap.memory_lock=true
      - "ES_JAVA_OPTS=-Xms512m -Xmx512m"
      - discovery.type=single-node
    ulimits:
      memlock:
        soft: -1
        hard: -1
    volumes:
      - data01:/usr/share/elasticsearch/data
    ports:
      - 9200:9200
  db:
    image: mysql:8.0.20
    volumes:
      - mysql:/var/lib/mysql:delegated
    restart: always
    platform: linux/x86_64
    ports:
      - '3307:3306'
    command: --default-authentication-plugin=mysql_native_password
    environment:
      MYSQL_ALLOW_EMPTY_PASSWORD: 1
  redis:
    image: redis:alpine
    restart: always
    ports:
      - '6380:6379'
    volumes:
      - ./volumes/redis-data:/data
    command: redis-server 
  rabbitmq:
    image: rabbitmq:3.9-management-alpine
    restart: always
    ports:
      - 5672:5672
      - 15672:15672
    volumes:
      - ./volumes/rabbitmq:/var/lib/rabbitmq
  web:
    build: .
    command: bash -c "bash ./init.sh && bundle exec rails s -p 3000 -b '0.0.0.0'"
    environment:
      - REDIS_HOST=redis
      - RABBITMQ_HOST=rabbitmq
      - ES_HOST=es01
    links:
      - db
      - redis
      - rabbitmq
      - es01
    depends_on:
      - db
      - redis
      - rabbitmq
      - es01
    ports:
      - '3000:3000'
    volumes:
      - .:/app:cached
      - bundle:/usr/local/bundle:delegated
      - node_modules:/app/node_modules
      - tmp-data:/app/tmp/sockets
  worker:
    build: .
    command: rake sneakers:run
    restart: always
    volumes:
      - .:/app
    links:
      - db
      - redis
      - es01
      - rabbitmq
    depends_on:
      - web
    environment:
      - WORKERS=ChatWorker,MessageWorker
      - MYSQL_HOST=db
      - REDIS_HOST=redis
      - RABBITMQ_HOST=rabbitmq
      - ES_HOST=es01
  rufus_worker:
    build: .
    restart: always
    command: rake rufus_job
    depends_on:
      - web
      - db

volumes:
  mysql:
  bundle:
  node_modules:
  tmp-data:
  redis:
  rabbitmq:
  data01:
 ```
- Test Docker

### Iniailize Models and Create Migrations

-Create `Application`  Model
- `rails g model Application token chats_count:integer name`
```ruby
  class Application < ApplicationRecord
     has_many :chats, dependent: :destroy
  end
```
-Create `Chat`  Model
- `rails g model Chat number:integer messages_count:integer application:references`
```ruby
class Chat < ApplicationRecord
  belongs_to :application
  has_many :messages, dependent: :destroy
end
```

-Create `Message`  Model
- `rails g model Message number:integer body chat:references`

```ruby
class Message < ApplicationRecord
  belongs_to :chat
  validates :body , presence: true
end
```

### Add Redis and RabbitMQ Publisher
- first I iniailized a `$bunny` , `sneakers` in `config/inializers`
 ```ruby
  $bunny = Bunny.new(:host => ENV['RABBITMQ_HOST'])
  Sneakers.configure(:amqp => "amqp://guest:guest@#{ENV['RABBITMQ_HOST']}:5672")
```
- Create `PublisherService`  Service in `lib` folder
```ruby
class PublisherService

    def self.publish(queue, message = {})
        @connection ||= $bunny.tap do |c|
            c.start
        end
        @channel = @connection.create_channel
        queuex = @channel.queue(queue,durable:true)
        queuex.publish(message.to_json, routing_key: queuex.name)
    end
end
```
-Create `RedisService`  Service in `lib` folder
```ruby
class RedisService
    def initialize
        @redis = $redis
    end
    def save_in_redis(key,value)
        @redis.set(key,value)
    end
    def get_from_redis(key)
        @redis.get(key) 
    end
    def save_hash_in_redis(hash,key,value)
        @redis.hset(hash,key,value)
    end
    def get_hash_value_by_key(hash,key)
        @redis.hget(hash,key)
    end
    def increment_counter(key)
        @redis.incr(key)
    end
end
```

