require 'elasticsearch/model'
class Message < ApplicationRecord
  belongs_to :chat
  validates :body , presence: true
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
    es_index_settings = {
      'analysis': {
        'filter': {
          'trigrams_filter': {
            'type':'ngram',
            'min_gram': 3,
            'max_gram': 3
          }
        },
        'analyzer': {
          'trigrams': {
            'type': 'custom',
            'tokenizer': 'standard',
            'filter': [
              'lowercase',
              'trigrams_filter'
            ]
          }
        }
      }
    }
    settings es_index_settings do
      mapping do
        indexes :body, type: 'string', analyzer: 'trigrams'
      end
    end

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
