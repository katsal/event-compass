class AddSenderReceiverIdRemoveUseridChatroomidToMessages < ActiveRecord::Migration[7.0]
  def change
    add_column :messages, :sender_id, :bigint, null: false
    add_column :messages, :recipient_id, :bigint, null: false
    remove_column :messages, :user_id, :bigint
    remove_column :messages, :chatroom_id, :bigint
    add_foreign_key :messages, :users, column: :sender_id
    add_foreign_key :messages, :users, column: :recipient_id
  end
end
