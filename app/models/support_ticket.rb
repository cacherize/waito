class SupportTicket < ActiveRecord::Base
  attr_accessible :email, :message, :reason, :user_id
end
