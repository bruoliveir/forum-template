class AddIndexToDiscussionsPath < ActiveRecord::Migration[5.0]
  def change
    add_index :discussions, :path
  end
end
