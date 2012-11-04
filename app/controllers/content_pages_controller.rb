class ContentPagesController < ApplicationController
  before_filter :authenticate_user!, except: [:show]

  def show
    user = User.find_by_slug(params[:user_id])
    redirect_to root_path if user.nil?
    @content_page = user.content_page
    redirect_to root_path if @content_page.nil?
  end

  def edit
    user = User.find_by_slug(params[:id])
    unless user == current_user
      flash[:alert] = t('label.this_is_not_your_page')
      redirect_to edit_user_registration_path
    else
      @content_page = user.content_page
      if @content_page.nil?
        flash.now[:alert] = view_context.raw "#{t('label.we_recommend_that_you_fill_out')}&nbsp;&nbsp;<a href='#{edit_user_registration_path}#profile' class='btn btn-success btn-small'>#{t('label.public_profile')}</a>"
        @content_page = user.build_content_page
      end
    end
  end

  def update

  end
end
