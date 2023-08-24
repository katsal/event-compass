class AddImageUrlToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :img_url, :string
  end
end
