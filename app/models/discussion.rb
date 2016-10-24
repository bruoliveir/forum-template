class Discussion < ApplicationRecord
  belongs_to :user, optional: true

  validates :user_id, presence: true
  validates :title, presence: true
  validates :body, presence: true

  PATH_DELIMITER = '.'

  after_create do
    self.path = self.path? ? self.path + self.id.to_s : self.id.to_s
    self.path += PATH_DELIMITER
    self.save
  end

  scope :most_recent_per_root, -> {
    group("SUBSTR(path, 0, INSTR(path, '.'))").reorder("created_at DESC")
    # select * from discussions group by substr(path, 0, instr(path, '.')) order by created_at desc;
  }

  def readonly?
    !path_changed? && !new_record?
  end

  def descendants
    Discussion.where("path LIKE ? || '%'", path).order("created_at, path")
  end

  def ancestors
    Discussion.where("? LIKE path || '%'", path)
  end
end
