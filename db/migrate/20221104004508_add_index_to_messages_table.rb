class AddIndexToMessagesTable < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :application_token, :string, nullable: false
    add_column :messages, :chat_number, :integer, nullable: false
    add_index :messages, %i(application_token chat_number)
  end
end
