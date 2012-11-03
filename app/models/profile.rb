class Profile < ActiveRecord::Base
  belongs_to :user

  attr_accessible :full_name, :date_of_birth, :country_code, :state_code, :city, :address, :email, :phone, :skype, :description

  validates :full_name, allow_blank: true, format: /\A[A-z\s\-\.]+\z/

  def description=(value)
    write_attribute(:description, Loofah.fragment(read_attribute(:description)).scrub!(:strip).to_s)
  end
end
