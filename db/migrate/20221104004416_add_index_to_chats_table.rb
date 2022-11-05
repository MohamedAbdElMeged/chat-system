class AddIndexToChatsTable < ActiveRecord::Migration[5.2]
  def change
    add_column :chats, :application_token, :string, nullable: false
    add_index :chats, %i(number application_token), unique: true
    add_index :chats, :application_token
  end
end
