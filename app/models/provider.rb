class Provider < ActiveRecord::Base
  belongs_to :user, touch: true
  attr_accessible :name, :uid

  validates :name, :presence => true, :inclusion => { in: User.omniauth_providers.map{ |i|i.to_s } }
  validates :uid,  :presence => true, :uniqueness => { scope: [:name] }

  def self.put_name(name)
    name.split('_').first
  end
end
