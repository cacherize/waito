class Post < ActiveRecord::Base
  attr_accessible :title, :description, :archived_at, :tag_list

  has_many :post_tags
  has_many :tags, through: :post_tags

  def tag_list=(values)
  end

  def tag_list
  end
end
