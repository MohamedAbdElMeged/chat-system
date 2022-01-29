
# Instabug Challenge

I applied at Instabug. I recently received this challenge to work on as part of the process.

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
