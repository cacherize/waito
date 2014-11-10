class SupportTicket < ActiveRecord::Base
  attr_accessible :email, :message, :reason, :user_id

  TICKET_REASONS = {
    "General Comment" => "general comment",
    "Unable to Sign Up" => "cant signup",
    "Report Bug" => "bug",
    "Other" => "other"
  }
end
