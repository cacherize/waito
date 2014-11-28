class Flag < ActiveRecord::Base
  attr_accessible :user_id, :reason

  belongs_to :flaggable, polymorphic: true
  belongs_to :user

  REASON_LIST = {
    'Spam' => 'spam',
    'Advertisement' => 'advertisement',
    'Obscene Content' => 'obscene',
    'Breaks Rules' => 'rules'
  }

  validates_presence_of :user_id, :reason
  validates_inclusion_of :reason, in: REASON_LIST.values, if: Proc.new{|f| f.reason.present?}
end
