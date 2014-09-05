class Post < ActiveRecord::Base
  attr_accessible :title, :description, :archived_at
end
