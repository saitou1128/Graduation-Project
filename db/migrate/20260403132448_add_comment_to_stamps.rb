class AddCommentToStamps < ActiveRecord::Migration[8.1]
  def change
    add_column :stamps, :comment, :text
  end
end
