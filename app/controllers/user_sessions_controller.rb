class UserSessionsController < ApplicationController
  
  def new
    @user_session = UserSession.new
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = 'You have been logged in'
      redirect_to root_url
    else
      flash[:notice] = 'Either your username or password is incorrect'
      render :action => 'new'
    end
  end
  
  def destroy
    @user_session = UserSession.find
    @user_session.destroy
    flash[:notice] = 'You have been logged out'
    redirect_to root_url
  end
  
end