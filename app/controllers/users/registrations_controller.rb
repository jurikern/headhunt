class Users::RegistrationsController < Devise::RegistrationsController
  def create
    super
  end

  def new
    super
  end

  def edit
    @profile = current_user.profile.nil? ? current_user.build_profile : current_user.profile
    super
  end

  def update
    super
  end
end
