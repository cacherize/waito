class User < ActiveRecord::Base
  attr_accessible :username, :email, :password, :password_confirmation, :avatar_url
  has_secure_password

  # ASSOCIATIONS =================
  has_many :posts
  has_many :reputations
  has_many :comments
  has_many :suggestions
  has_many :support_tickets
  has_many :flags
  has_many :pins

  # VALIDATIONS ==================
  validates :email, presence: true, on: :create
  validates_format_of :email, with:  /^[-0-9a-z.+_]+@[-0-9a-z.+_]+\.[a-z]{2,4}$/i
  validates_uniqueness_of :email, case_sensitive: false
  validates :username, presence: true, uniqueness: {case_sensitive: false}
  validates_length_of :username, minimum: 3, maximum: 30
  validates_format_of :username, with: /^[a-z0-9_-]*$/i, message: 'must only contain alphanumeric characters'
  validates :password, presence: true, on: :create
  validates_length_of :password, minimum: 8, maximum: 100, if: lambda{self.password.present?}

  # CALLBACKS ====================
  before_validation :downcase_email
  before_create { generate_token(:auth_token) }

  def to_param
    username.parameterize
  end

  def avatar_url
    url = read_attribute(:avatar_url)
    url ? (S3_BUCKET.url+url) : DEFAULT_AVATAR_URL
  end

  def downcase_email
    self.email.downcase! if self.email_changed?
  end

  def generate_token(column)
    column = column.to_sym

    self[column] = loop do
      token = SecureRandom.urlsafe_base64(nil, false)
      break token unless User.exists?(column => token)
    end
  end

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

  def reset_password
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    self.save!
    Messager.reset_password(self.id).deliver
  end

  def update_avatar(attributes)
    old_avatar_url = self.avatar_url

    if saved = self.update_attributes(avatar_url: attributes[:avatar_url], avatar_processed: false) && old_avatar_url
      old_avatar_obj = S3_BUCKET.objects[old_avatar_url]
      old_avatar_obj.delete if old_avatar_obj.exists? && old_avatar_obj.key != self.avatar_url
    end

    return saved
  end
end
