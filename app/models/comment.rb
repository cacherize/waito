class Comment < ActiveRecord::Base
  attr_accessible :user_id, :message
  belongs_to :commentable, polymorphic: true
  belongs_to :user
  has_many :comments, as: :commentable

  SORT_OPTIONS = {
    "Top Rated" => "top",
    "Most Recent" => "recent",
    "Oldest First" => "oldest"
  }

  def self.filter_comments(commentable, sort=nil)
    sort = "top" unless sort && SORT_OPTIONS.values.include?(sort)
    
    case sort
    when "recent"
      comments = commentable.comments.order('created_at DESC')
    when "oldest"
      comments = commentable.comments.order('created_at ASC')
    else
      comments = commentable.comments
    end

    comments
  end
end
