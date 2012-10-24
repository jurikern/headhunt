class Provider < ActiveRecord::Base
  AUTHORIZED_PROVIDERS = ['twitter', 'facebook', 'linkedin', 'google_oauth2', 'github']

  belongs_to :user
  attr_accessible :name, :uid

  validates :name, :presence => true, :inclusion => { in: AUTHORIZED_PROVIDERS }
  validates :uid,  :presence => true, :uniqueness => { scope: [:name] }
end
