
# Instabug Challenge

I applied at Instabug. I recently received this challenge to work on as part of the process.

# How To Run The Challenge

We will only write this command to run the whole stack 
``` bash
docker-compose up
``` 

# My Approach
### Understand the requirements
> Extract classes (Application, Chat, Message)
> Define Relations between classes 
### Setup The Docker
> Add (RoR, MySQL, ElasticSearch , Redis , RabbitMQ, Sneakers, RufusScheduler) images
> Test Docker

<ul>
  <li>Understand the requirements</li>
      <ul>
      <li>Extract classes (Application, Chat, Message)</li>
      <li>Define Relations between classes </li>
    </ul>
  <li>Setup The Docker
        <ul>
        <li>Add (RoR, MySQL, ElasticSearch , Redis , RabbitMQ, Sneakers, RufusScheduler) images</li>
        <li>Test Docker</li>
        </ul>
     </li>
  <li>Iniailize Models and Create Migrations
    <ul>
      <li>
               Create <code> Application </code> Model 
        
        </li>
      <li>
        ```
          class Application < ApplicationRecord
             has_many :chats, dependent: :destroy
          end
      ```
      </li>
      <li>Indented item</li>
    </ul>
  </li>
  <li>Fourth item</li>
</ul>
