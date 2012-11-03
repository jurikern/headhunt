class Profile < ActiveRecord::Base
  belongs_to :user

  attr_accessible :full_name, :date_of_birth, :country_code, :state_code, :city, :address, :email, :phone, :skype, :description

  validates :full_name, allow_blank: true, format: /\A[A-z\s\-\.]+\z/

  before_save :perform_attributes!

  protected

  def perform_attributes!
    self.description = Loofah.fragment(self.description).scrub!(:escape).to_s
  end
end
