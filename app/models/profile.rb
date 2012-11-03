class Profile < ActiveRecord::Base

  belongs_to :user

  attr_accessible :full_name, :country_code, :state_code, :city, :address, :email, :phone, :skype
end
