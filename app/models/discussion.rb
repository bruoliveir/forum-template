class Discussion < ApplicationRecord
  belongs_to :user, :optional => true
  belongs_to :parent, :class_name => "Discussion", :optional => true
  has_many :children, :class_name => "Discussion", :foreign_key => "parent_id"

  def descendents
    children.map do |child|
      [child] + child.descendents
    end.flatten
  end
end
