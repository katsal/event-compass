class RemoveStatusFromEventList < ActiveRecord::Migration[7.0]
  def change
    remove_column :event_lists, :status
  end
end
