class AddPathToDiscussions < ActiveRecord::Migration[5.0]
  def change
    add_column :discussions, :path, :string
  end
end
