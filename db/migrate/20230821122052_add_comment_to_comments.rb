class AddCommentToComments < ActiveRecord::Migration[7.0]
  def change
    add_column :comments, :comment, :text
  end
end
