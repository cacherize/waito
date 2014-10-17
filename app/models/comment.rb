class Comment < ActiveRecord::Base
  attr_accessible :user_id, :message
  belongs_to :commentable, polymorphic: true
  belongs_to :user
  has_many :reputations, as: :reputable
  has_many :comments, as: :commentable

  SORT_OPTIONS = {
    "Top Rated" => "top",
    "Most Recent" => "recent",
    "Oldest First" => "oldest"
  }
end
