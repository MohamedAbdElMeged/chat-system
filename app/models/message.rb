require 'elasticsearch/model'
class Message < ApplicationRecord
  belongs_to :chat
  validates :body , presence: true
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  
    def self.partial_search(q,chat)
      q = "*#{q}*"
    __elasticsearch__.search({
      "query": {
        "bool": {
          "must": {
            "wildcard": { "body": q }
          },
          "filter": {
            "term": { "chat_id": chat.id }
          }
        }
      }
    })
      
    end
    
end
