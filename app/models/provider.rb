class Provider < ActiveRecord::Base
  AUTHORIZED_PROVIDERS = ['twitter', 'facebook', 'linkedin', 'google', 'github']

  belongs_to :user
  attr_accessible :name, :uid

  validates :name, :presence => true, :inclusion => { in: AUTHORIZED_PROVIDERS }
  validates :uid,  :presence => true, :uniqueness => { scope: [:provider] }
end
