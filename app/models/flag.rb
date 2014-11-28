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
end
