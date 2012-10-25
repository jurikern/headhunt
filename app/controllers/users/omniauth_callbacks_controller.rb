class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_filter :authenticate_user!, only: [:destroy]

  def facebook
    @user = User.find_for_facebook_oauth(request.env['omniauth.auth'], current_user)
    authorize
  end

  def google_oauth2
    @user = User.find_for_google_oauth2(request.env['omniauth.auth'], current_user)
    authorize
  end

  def linkedin
    @user = User.find_for_linkedin_oauth(request.env['omniauth.auth'], current_user)
    authorize
  end

  def github
    @user = User.find_for_github_oauth(request.env['omniauth.auth'], current_user)
    authorize
  end

  def twitter
    @user = User.find_for_twitter_oauth(request.env['omniauth.auth'], current_user)
    authorize
  end

  def destroy
    provider = current_user.providers.find_by_name(params[:name])

    unless provider.nil?
      provider.destroy
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.deleted', kind: params[:name].capitalize
    end
    redirect_to edit_user_registration_path
  end

  protected

  def authorize
    provider = request.env['omniauth.auth'].provider.capitalize

    if @user.persisted?
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: provider
      redirect_path = user_signed_in? ? edit_user_registration_path : root_path
      sign_in @user, :event => :authentication
      redirect_to redirect_path
    else
      session["devise.#{provider}_data"] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end
end
