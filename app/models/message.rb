require 'elasticsearch/model'
class Message < ApplicationRecord
  belongs_to :chat
  validates :body, presence: true
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  settings index: {
    number_of_shards: 1,
    number_of_replicas: 0,
    analysis: {
      analyzer: {
        trigram: {
          tokenizer: 'trigram'
        }
      },
      tokenizer: {
        trigram: {
          type: 'ngram',
          min_gram: 3,
          max_gram: 3,
          token_chars: %w(letter digit)
        }
      }
    }
  } do
    mappings dynamic: true do
      indexes :body, type: :text, analyzer: 'trigram'
      indexes :chat_id, type: :integer
    end
  end

  after_commit on: :update do
    __elasticsearch__.index_document
  end

  def self.partial_search(value, chat)
    query = "#{value}*"
    __elasticsearch__.search(
      query: {
        bool: {
          must: {
            multi_match: {
              query: query,
              analyzer: 'trigram',
              fields: [:body]
            }
          },
          filter: [
            { term: { chat_id: chat.id } },
          ]
        }
      },
    )
  end
end
