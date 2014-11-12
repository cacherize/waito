class SupportTicket < ActiveRecord::Base
  attr_accessible :email, :message, :reason, :user_id, :archived_at

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
  validate :past_resubmission_period

  def past_resubmission_period
    last_ticket = SupportTicket.where(public_address: self.public_address).order('created_at ASC').last

    if last_ticket && last_ticket.created_at > 5.minutes.ago
      timer = ((last_ticket.created_at - 5.minutes.ago)/60).ceil
      errors.add(:base, "You already submitted a ticket. Please wait #{timer} minute#{'s' unless timer == 1} before submitting another one.")
    end
  end

  TICKET_REASONS = {
    "General Comment" => "general comment",
    "Unable to Sign Up" => "cant signup",
    "Report Bug" => "bug",
    "Other" => "other"
  }

  def archived?
    !!self.archived_at
  end

  def display_reason
    TICKET_REASONS.key(self.reason)
  end
end
