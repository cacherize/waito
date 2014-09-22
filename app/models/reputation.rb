class Reputation < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :reputable, polymorphic: true
  belongs_to :user
end
