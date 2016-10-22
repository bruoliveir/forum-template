class Discussion < ApplicationRecord
  belongs_to :user, :optional => true
  belongs_to :parent, :class_name => "Discussion", :optional => true
  has_many :children, :class_name => "Discussion", :foreign_key => "parent_id"

  validates :user_id, presence: true
  validates :title, presence: true
  validates :body, presence: true

  scope :roots, -> {
    where(:parent_id => nil)
  }

  scope :branches, -> {
    where.not(:parent_id => nil)
  }

	def readonly?
	  !new_record?
	end

  def descendents
    self_and_descendents - [self]
  end

  def self_and_descendents
    self.class.tree_for(self)
  end

  def self.tree_for(instance)
    tree_sql =  <<-SQL
      WITH RECURSIVE search_tree(id, path) AS (
          SELECT id, [id]
          FROM #{table_name}
          WHERE id = #{instance.id}
        UNION ALL
          SELECT #{table_name}.id, path || #{table_name}.id
          FROM search_tree
          JOIN #{table_name} ON #{table_name}.parent_id = search_tree.id
          WHERE NOT #{table_name}.id IN (path)
      )
      SELECT id FROM search_tree ORDER BY path
    SQL
    where("#{table_name}.id IN (#{tree_sql})")
  end
end
