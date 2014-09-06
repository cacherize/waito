class Post < ActiveRecord::Base
  attr_accessible :title, :description, :archived_at, :tag_list

  def tag_list=(values)
  end

  def tag_list
  end
end
