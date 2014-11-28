class Post < ActiveRecord::Base
  attr_accessible :title, :description, :archived_at, :tag_list

  has_many :post_tags, autosave: true
  has_many :tags, through: :post_tags
  has_many :reputations, as: :reputable
  has_many :comments, as: :commentable
  has_many :flags, as: :flaggable
  belongs_to :user

  validates :title, presence: true, length: {maximum: 150}
  validates :tags, presence: {message: "must be added"}
  validate :tag_count

  def tag_count
    errors.add(:tags, 'exceed maximum allowed (maximum 5 tags)') if tags.size > 5
  end

  def tag_list=(values)
    self.tag_ids = values.to_s.split(",")
  end

  def deleted?
    self.deleted_at.present?
  end

  def reputation
    reputations.pluck(:value).inject(:+).to_i
  end
end
