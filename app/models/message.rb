require 'elasticsearch/model'
class Message < ApplicationRecord
  belongs_to :chat
  validates :body , presence: true
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

end
