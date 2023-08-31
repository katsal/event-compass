class AddSocialToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :social, :boolean, default: false
    remove_column :users, :status, :string
  end
end
