class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :name
      t.string :location
      t.text :description
      t.string :url
      t.float :price
      t.date :start_date
      t.date :end_date
      t.float :latitude
      t.float :longitude
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
