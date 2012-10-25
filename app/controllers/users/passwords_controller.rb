class Users::PasswordsController < Devise::PasswordsController
  skip_before_filter :require_no_authentication, only: [:new, :edit, :update]

  def new
    if user_signed_in?
      current_user.send_reset_password_instructions
      flash[:notice] = I18n.t 'devise.passwords.send_instructions'
      redirect_to edit_user_registration_path
    else
      super
    end
  end

  def create
    super
  end

  def edit
    super
  end

  def update
    super
  end
end
