class CreateLists < ActiveRecord::Migration[7.0]
  def change
    create_table :lists do |t|
      t.references :user, null: false, foreign_key: true
      t.string :location
      t.string :name
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
