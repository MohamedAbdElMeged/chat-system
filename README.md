
The callenge is chat system that has multiple Application identified by token, each Application has many chats identified by a number ( number should start from 1) , each Chat has many messages identified by a number ( number should start from 1)
- the endpoints should be RESTful
- Use MySQL as datastore
- use ElasticSearch for searching through messages of a specific chat
- use Docker to contatinerize the application
- use Sidekiq to create `chats` and `messages`
- Personally I used `rufus-scheduler` to create a cron job to update chats_count and messages_count every 30 minutes

# How To Run The Challenge
- First run 
 ``` bash
docker-compose build
``` 
- Then run
``` bash
docker-compose up
``` 

# My Approach
### Understand the requirements
- Extract classes (Application, Chat, Message)
- Define Relations between classes 


### Setup The Docker
- Add (RoR, MySQL, ElasticSearch , Redis , SidekiqWorker , RufusScheduler) images
- Test Docker

### Iniailize Models and Create Migrations

-Create `Application` Model

-Create `Chat` Model

-Create `Message` Model


### Add Redis Service
- Initialize  `REDIS`  in `config/initalizers`
-Create `RedisService`  Service in `lib` folder

### Add ElasticSearch To `Message` Model
- Add `partial_search` method to search in message bodies for a specific chat

### Add `helpers` Methods
- Create `GenerateApplicationTokenHelper` to create application's token using `securerandom` gem

## Create APIs endpoints
- create `applications` endopoints
-  create `chats` endopoints
-  create `messages` endopoints


### Config Routes
## Testing with curl
- create new application

curl -X POST http://localhost:3000/api/v1/applications/ -d '{"name": "application1"}' -H "Content-Type: application/json"

- list applications

curl -X GET http://localhost:3000/api/v1/applications/

- create chat for application1

curl -X POST http://localhost:3000/api/v1/applications/Z6Ytw68GoCeceFRDdZL8zj97/chats

- list chats for application1

curl -X GET http://localhost:3000/api/v1/applications/Z6Ytw68GoCeceFRDdZL8zj97/chats

- create message for chat 1

curl -X POST http://localhost:3000/api/v1/applications/Z6Ytw68GoCeceFRDdZL8zj97/chats/1/messages/ -d '{"body": "hello"}' -H "Content-Type: application/json"

- list all messages for chat 1

curl -X GET http://localhost:3000/api/v1/applications/Z6Ytw68GoCeceFRDdZL8zj97/chats/1/messages/

- partial search in specific chat messages 

curl -X GET "http://localhost:3000/api/v1/applications/Z6Ytw68GoCeceFRDdZL8zj97/chats/6/messages/search?query=hel"

## Testing with Rspec
- unit testing
- performance testing
- api testing
