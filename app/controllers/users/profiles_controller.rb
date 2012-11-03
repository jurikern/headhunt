class Users::ProfilesController < ApplicationController
  before_filter :authenticate_user!

  def create
    @profile = current_user.build_profile(params[:profile])
    if @profile.save
      flash[:notice] = t('devise.registrations.updated')
      redirect_to edit_user_registration_path
    else
      @section = 'profile'
      render 'users/registrations/edit'
    end
  end

  def update
    @profile = current_user.profile

    if @profile.update_attributes(params[:profile])
      flash[:notice] = t('devise.registrations.updated')
      redirect_to edit_user_registration_path
    else
      @section = 'profile'
      render 'users/registrations/edit'
    end
  end

  def show
    redirect_to edit_user_registration_path
  end

  def subregion_options
    render partial: 'users/profiles/subregion_select'
  end

end
