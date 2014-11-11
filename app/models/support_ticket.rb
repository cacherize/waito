class SupportTicket < ActiveRecord::Base
  attr_accessible :email, :message, :reason, :user_id

  belongs_to :user

  validates :email, 
    presence: true, 
    format: {
      with:  /^[-0-9a-z.+_]+@[-0-9a-z.+_]+\.[a-z]{2,4}$/i, 
      if: lambda{self.email.present?}
    }
  validates :message, 
    presence: true, 
    length: {
      minimum: 5,
      maximum: 1000,
      if: lambda{self.message.present?}
    }
  validates :reason, presence: true

  TICKET_REASONS = {
    "General Comment" => "general comment",
    "Unable to Sign Up" => "cant signup",
    "Report Bug" => "bug",
    "Other" => "other"
  }

  def display_reason
    TICKET_REASONS.key(self.reason)
  end
end
