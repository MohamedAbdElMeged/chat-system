class AddChatsCountToApplications < ActiveRecord::Migration[5.2]
  def change
    add_column :applications, :chats_count, :integer, default: 0
    change_column :chats, :messages_count, :integer, default: 0
    # Ex:- :default =>''
    # Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
