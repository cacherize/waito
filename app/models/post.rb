class Post < ActiveRecord::Base
  attr_accessible :title, :description, :archived_at, :tag_list

  has_many :post_tags, autosave: true
  has_many :tags, through: :post_tags

  validates :title, presence: true, length: {maximum: 325}

  def tag_list=(values)
    self.tag_ids = values.to_s.split(",")
  end
end
