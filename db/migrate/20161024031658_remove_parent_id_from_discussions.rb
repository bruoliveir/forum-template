class RemoveParentIdFromDiscussions < ActiveRecord::Migration[5.0]
  def change
    remove_column :discussions, :parent_id, :integer
  end
end
