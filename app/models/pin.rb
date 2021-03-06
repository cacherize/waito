class Pin < ActiveRecord::Base
  attr_accessible :user_id, :post_id
  belongs_to :user
  belongs_to :post

  validates_presence_of :user_id, :post_id
end
