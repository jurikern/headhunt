class User < ActiveRecord::Base

  has_many :providers, dependent: :destroy

  devise :database_authenticatable, :registerable, :recoverable,
         :confirmable, :rememberable, :validatable, :encryptable, :omniauthable

  attr_accessible :username, :email, :password, :password_confirmation, :remember_me
  attr_accessor   :login

  validates :username, :presence => true,
                       :uniqueness => true,
                       :format => { with: /\A[A-z0-9\-_\.]+\z/ },
                       :length => { in: 2..50 }

  validates :uid, :allow_blank => true,
                  :uniqueness => { scope: [:provider] }

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(['lower(username) = :value OR lower(email) = :value', { value: login.downcase }]).first
    else
      where(conditions).first
    end
  end

  def self.find_for_facebook_oauth(auth, signed_in_resource = nil)
    provider = Provider.where(:provider => auth.provider, :uid => auth.uid).first
    unless provider
      User.transaction do
        provider = Provider.new(
            name: auth.provider,
            uid:  auth.uid,
        )
        user = User.find_by_email(auth.info.email) ? provider.user = user : provider.user.create!({
            username: User.generate_random_username,
            email:    auth.info.email,
            password: Devise.friendly_token[4,20]
        }).confirm!
        provider.save!
      end
    end
    user
  end

  protected

  def self.generate_random_email
    random_email = "user.#{Random.rand(8)}@headhunt.ee"
    User.exists?(email: random_email) ? return random_email : generate_random_email
  end

  def self.generate_random_username
    random_username = "user.#{Random.rand(8)}"
    User.exists?(username: random_username) ? return random_username : generate_random_username
  end
end
