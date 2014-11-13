class Suggestion < ActiveRecord::Base
  attr_accessible :title, :message

  belongs_to :user
end
