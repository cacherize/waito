class Reputation < ActiveRecord::Base
  attr_accessible :user_id, :value
  belongs_to :reputable, polymorphic: true
  belongs_to :user

  def self.create_or_update_rep object, user, value
    rep = object.reputations.where(user_id: user.id).first

    unless rep
      rep = object.reputations.new(user_id: user.id)
    end

    rep.value = value

    return rep
  end
end
