class LoadComments
  attr_accessor :conjoined_comments, :comments, :total
  def initialize(commentable, user, pagination, sort=nil)
    sort = "top" unless sort && Comment::SORT_OPTIONS.values.include?(sort)
    @user = user
    @commentable = commentable
    @comments = load_comments(pagination, sort)
    @replies = load_replies
    @reputations = load_reputations

    conjoin_comments_and_reputations
  end

  def load_comments(pagination, sort)
    comments = @commentable.comments
    @total = comments.size

    case sort
    when "recent"
      comments = comments.order('created_at DESC')
    when "oldest"
      comments = comments.order('created_at ASC')
    else
      @comment_reps = Reputation.where(reputable_type: 'Comment').where(reputable_id: comments.pluck(:id))

      sort_hash = Hash.new
      comments.each do |c|
        reps = @comment_reps.select{|r| r.reputable_id == c.id}.map(&:value)
        sort_hash.merge!(c.id => reps.inject(:+) || 0.0)
      end

      comments = comments.sort_by{|c| sort_hash[c.id]}.reverse
    end

    if comments.kind_of?(ActiveRecord)
      comments = comments.page(pagination).per(5)
    else
      comments = Kaminari.paginate_array(comments).page(pagination).per(12)
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
    # @comment_reps ||= []
    @reply_ids = @replies.map(&:id)
    @comment_ids = @comments.map(&:id) #- @comment_reps.map(&:id)
    reputable_ids = @comment_ids + @reply_ids

    reps = Reputation.where(reputable_type: 'Comment').where(reputable_id: reputable_ids)
    return reps
  end

  def conjoin_comments_and_reputations
    @conjoined_comments = {}
    @users = User.where(id: (@comments.map(&:user_id) + @replies.map(&:user_id)))

    if @user
      @user_reps = @reputations.select{|r| r.user_id == @user.id}
    end

    @comments.each do |c|
      comment_rep = @reputations.select{|rep| rep.reputable_id == c.id}.map(&:value).inject(:+) || 0
      replies = @replies.select{|r| r.commentable_id == c.id}
      @conjoined_replies = {}

      replies.each do |r|
        reply_rep = @reputations.select{|rep| rep.reputable_id == r.id}.map(&:value).inject(:+) || 0
        user = @users.select{|u| u.id == c.user_id}.first

        if @user_reps
          user_rep = @user_reps.find{|rep| rep.reputable_id == r.id}
        end

        @conjoined_replies.merge!(r => {reputation: reply_rep, user_rep: user_rep, user: user})
      end

      user = @users.select{|u| u.id == c.user_id}.first

      if @user_reps
        user_rep = @user_reps.find{|r| r.reputable_id == c.id}
      end

      @conjoined_comments.merge!(c => {reputation: comment_rep, replies: @conjoined_replies, user_rep: user_rep, user: user})
    end

    @conjoined_comments
  end
end
