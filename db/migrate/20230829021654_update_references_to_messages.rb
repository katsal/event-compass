class UpdateReferencesToMessages < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :messages, :users, column: :sender_id
    remove_foreign_key :messages, :users, column: :recipient_id
    remove_column :messages, :sender_id, :bigint, null: false
    remove_column :messages, :recipient_id, :bigint, null: false
    add_reference :messages, :sender, foreign_key: { to_table: :users }
    add_reference :messages, :recipient, foreign_key: { to_table: :users }
  end
end
