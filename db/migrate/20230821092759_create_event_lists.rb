class CreateEventLists < ActiveRecord::Migration[7.0]
  def change
    create_table :event_lists do |t|
      t.references :event, null: false, foreign_key: true
      t.references :list, null: false, foreign_key: true

      t.timestamps
    end
  end
end
