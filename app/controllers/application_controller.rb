class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password
  helper_method :current_user
  
  rescue_from ActiveRecord::RecordNotFound, :with => :show_error
  rescue_from NoMethodError, :with => :show_error
  
  protected
    def show_error
      redirect_to :controller => 'error', :action => 'missing_page'
    end
  
  
  private
  
    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.record
    end
    
    def require_login
      if !current_user
        redirect_to login_path
      end
    end
end