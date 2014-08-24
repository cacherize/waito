class User < ActiveRecord::Base
  attr_accessible :username, :email, :password, :password_confirmation
  has_secure_password

  validates :email, presence: true, on: :create
  validates_format_of :email, with:  /^[-0-9a-z.+_]+@[-0-9a-z.+_]+\.[a-z]{2,4}$/i
  validates_uniqueness_of :email, case_sensitive: false
  validates :username, presence: true, uniqueness: {case_sensitive: false}
  validates_length_of :username, minimum: 3, maximum: 30
  validates_format_of :username, with: /^[a-z0-9_-]*$/i, message: 'must only contain alphanumeric characters'
  validates :password, presence: true, on: :create
  validates_length_of :password, minimum: 8, maximum: 100, if: lambda{self.password.present?}

  def self.username_search(arg)
    where('lower(username) = ?', arg.downcase).first
  end

  def self.find_by_email_or_username(arg)
    if arg.match(/^[-0-9a-z.+_]+@[-0-9a-z.+_]+\.[a-z]{2,4}$/i)
      find_by_email(arg.downcase)
    else
      where("lower(username) = ?", arg.downcase).first
    end
  end
end
