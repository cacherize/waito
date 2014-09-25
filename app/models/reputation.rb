class Reputation < ActiveRecord::Base
  attr_accessible :user_id, :value
  belongs_to :reputable, polymorphic: true
  belongs_to :user
end
