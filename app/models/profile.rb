class Profile < ActiveRecord::Base
  belongs_to :user

  attr_accessible :full_name, :date_of_birth, :country_code, :state_code, :city, :address,
                  :email, :phone, :skype, :description, :www, :github

  validates :full_name, allow_blank: true, format: /\A[A-z\s\-\.]+\z/

  before_save :perform_attributes!

  def age
    now = Time.now.utc.to_date
    now.year - self.date_of_birth.year - (self.date_of_birth.to_date.change(year: now.year) > now ? 1 : 0)
  end

  protected

  def perform_attributes!
    self.description = Loofah.fragment(self.description).scrub!(:escape).to_s

    if self.country_code and carmen_country = Carmen::Country.coded(self.country_code)
      self.country = carmen_country.name.downcase
      self.state   = carmen_country.subregions.coded(self.state_code).name.downcase if self.state_code
    end

    self.date_of_birth = Date.current unless self.date_of_birth
  end
end
