class Discussion < ApplicationRecord
  include ProfanityFilter

  belongs_to :user, optional: true

  validates :user_id, presence: true
  validates :title, presence: true
  validates :body, presence: true

  PATH_DELIMITER = '.'

  after_find do
    self.title = clean(self.title)
    self.body = clean(self.body)
  end

  after_create do
    (self.path ||= '') << self.class.encode_path(self.id.to_s)
    self.save
  end

  scope :most_recent_per_root, -> (limit, offset) {
    find_by_sql(
      "SELECT d.* FROM (
        SELECT MAX(created_at) AS c,
        SUBSTR(path, 1, CAST(SUBSTR(path, 1,1) AS INTEGER) + 1) AS p
        FROM discussions
        GROUP BY p
      ) l
      JOIN discussions d
      ON l.p = d.path ORDER BY l.c DESC
      LIMIT #{limit}
      OFFSET #{offset}"
    )
  }

  def readonly?
    !path_changed? && !new_record?
  end

  def descendants
    Discussion.where("path LIKE ? || '%'", path)
  end

  def ancestors
    Discussion.where("? LIKE path || '%'", path)
  end

  def self.encode_path(path)
    path = path.to_i.to_s(36)
    length = path.length.to_s(36)
    length + path
  end

  def self.decode_path(path)
    path = path.dup
    while !path.empty?
      length = path.slice!(0).to_i(36).to_s(10).to_i
      (result ||= '') << path.slice!(0, length).to_i(36).to_s(10) + PATH_DELIMITER
    end
    result
  end
end
