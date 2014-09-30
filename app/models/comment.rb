class Comment < ActiveRecord::Base
  attr_accessible :user_id, :message
  belongs_to :commentable, polymorphic: true
  belongs_to :user
  has_many :comments, as: :commentable
end
