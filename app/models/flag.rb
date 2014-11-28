class Flag < ActiveRecord::Base
  attr_accessible :user_id, :reason

  belongs_to :flaggable, polymorphic: true
  belongs_to :user
end
