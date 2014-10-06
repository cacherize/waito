class Comment < ActiveRecord::Base
  attr_accessible :user_id, :message
  belongs_to :commentable, polymorphic: true
  belongs_to :user
  has_many :reputations, as: :reputable
  has_many :comments, as: :commentable

  SORT_OPTIONS = {
    "Top Rated" => "top",
    "Most Recent" => "recent",
    "Oldest First" => "oldest"
  }

  def self.load_comments(commentable, pagination, sort=nil)
    sort = "top" unless sort && SORT_OPTIONS.values.include?(sort)
    comments = commentable.comments

    case sort
    when "recent"
      comments = comments.order('created_at DESC')
    when "oldest"
      comments = comments.order('created_at ASC')
    else
      comments = comments
    end

    comments = comments.page(pagination).per(5)

    comments
  end
end
