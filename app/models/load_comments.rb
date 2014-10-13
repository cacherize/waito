class LoadComments
  attr_accessor :conjoined_comments, :comments
  def initialize(commentable, user, pagination, sort=nil)
    sort = "top" unless sort && SORT_OPTIONS.values.include?(sort)
    @user = user
    @commentable = commentable
    @comments = load_comments(pagination, sort)
    @replies = load_replies
    @reputations = load_reputations

    conjoin_comments_and_reputations
  end

  def load_comments(pagination, sort)
    comments = @commentable.comments

    case sort
    when "recent"
      comments = comments.order('created_at DESC')
    when "oldest"
      comments = comments.order('created_at ASC')
    else
      @comment_reps = Reputation.where(reputable_type: 'Comment').where(reputable_id: comments.pluck(:id))
      grouped_comments = @comment_reps.group_by(&:reputable_id)
      grouped_comments.each{|c, reps| grouped_comments[c] = reps.map(&:value).inject(:+)}
      comments = comments.sort_by{|c| grouped_comments[c.id] || 0}.reverse
    end

    if comments.kind_of?(ActiveRecord)
      comments = comments.page(pagination).per(5)
      @comment_ids = comments.pluck(:id)
    else
      comments = Kaminari.paginate_array(comments).page(pagination).per(5)
    end

    comments
  end

  def load_replies
    return [] if @comments.blank?

    replies = Comment.where(commentable_type: 'Comment').where(commentable_id: @comments.map(&:id))
    @reply_ids = replies.pluck(:id)
    replies
  end

  def load_reputations
    @reply_ids ||= []
    @comment_ids ||= []
    @comment_reps ||= []
    reputable_ids = @comment_ids + @reply_ids

    reps = @comment_reps + Reputation.where(reputable_type: 'Comment').where(reputable_id: reputable_ids)
    return reps
  end

  def conjoin_comments_and_reputations
    @conjoined_comments = {}
    @users = User.where(id: (@comments.map(&:user_id) + @replies.map(&:user_id)))

    if @user
      @user_reps = @reputations.select{|r| r.user_id == @user.id}
    end

    @comments.each do |c|
      rep_value = @reputations.select{|r| r.reputable_id == c.id}.inject(:+) || 0
      replies = @replies.select{|r| r.commentable_id == c.id}

      @conjoined_replies = {}

      replies.each do |r|
        rep_value = @reputations.select{|r| r.reputable_id == r.id}.inject(:+) || 0
        user = @users.select{|u| u.id == c.user_id}.first

        if @user_reps
          user_rep = @user_reps.select{|r| r.reputable_id == r.id}
        end

        @conjoined_replies.merge!(r => {reputation: rep_value, user_rep: user_rep, user: user})
      end

      user = @users.select{|u| u.id == c.user_id}.first

      if @user_reps
        user_rep = @user_reps.select{|r| r.reputable_id == c.id}
      end

      @conjoined_comments.merge!(c => {reputation: rep_value, replies: @conjoined_replies, user_rep: user_rep, user: user})
    end

    @conjoined_comments
  end
end
