class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

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

  protected

  def authorize
    provider = request.env['omniauth.auth'].provider.capitalize

    if @user.persisted?
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: provider
      sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.#{provider}_data"] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end
end
