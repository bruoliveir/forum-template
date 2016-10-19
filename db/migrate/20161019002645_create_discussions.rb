class CreateDiscussions < ActiveRecord::Migration[5.0]
  def change
    create_table :discussions do |t|
      t.integer :parent_id
      t.integer :user_id
      t.string :title
      t.string :body

      t.datetime :created_at, null: false
    end
  end
end
