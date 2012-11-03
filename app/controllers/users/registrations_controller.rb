class Users::RegistrationsController < Devise::RegistrationsController
  def create
    super
  end

  def new
    super
  end

  def edit
    bind_profile
    super
  end

  def update
    bind_profile
    @section = 'account'
    super
  end

  protected

  def bind_profile
    @profile = current_user.profile.nil? ? current_user.build_profile : current_user.profile
  end

  def after_sign_up_path_for(resource)
    edit_user_registration_path
  end

  def after_update_path_for(resource)
    edit_user_registration_path
  end
end
