class AddStatusToEventList < ActiveRecord::Migration[7.0]
  def change
    add_column :event_lists, :status, :string
  end
end
