class User < ActiveRecord::Base
  attr_accessible :username, :email, :password, :password_confirmation
  has_secure_password
  
  validates :password, presence: true, on: :create
  validates :email, presence: true,
    uniqueness: {case_sensitive: false},
    format: {
      with: /^[-0-9a-z.+_]+@[-0-9a-z.+_]+\.[a-z]{2,4}$/i,
      if: lambda{self.email.present?}
    },
    on: :create
  validates :username, presence: true,
    uniqueness: {case_sensitive: false}, 
    length: {minimum: 3, maximum: 30,
      too_long:  "is too long (max 30 chars)",
      too_short: "is too short (min 3 chars)",
      if: lambda{self.username.present?}
    },
    format: {
      with: /^[a-z0-9_-]*$/i,
      message: 'must only contain alphanumeric characters',
      if: lambda{self.username.present?}
    }
end
