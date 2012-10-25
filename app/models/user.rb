class User < ActiveRecord::Base
  include AuthorizeBehavior

  has_many :providers

  devise :database_authenticatable, :registerable, :recoverable,
         :confirmable, :rememberable, :validatable, :encryptable, :omniauthable

  attr_accessible :username, :email, :password, :password_confirmation, :remember_me
  attr_accessor   :login

  validates :username, :presence => true,
                       :uniqueness => true,
                       :format => { with: /\A[A-z0-9\-_\.]+\z/ },
                       :length => { in: 2..50 }

  def include_provider?(provider_name)
    self.providers.map{ |i|i.name }.include?(provider_name)
  end
end
