class UsersController < ApplicationController
  
  current_tab :profile
  
  # GET /users
  # GET /users.xml
  def index
    @users = User.search(params[:search], params[:page], params[:per])

    respond_to do |format|
      format.html
      format.xml
      format.rss  { render :rss => @users }
      format.atom  { render :atom => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find_by_username(params[:username])
    
    if @user.nil?
      raise ActiveRecord::RecordNotFound
    end

    respond_to do |format|
      format.html # show.html.erb
      format.xml
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /users/1/edit
  def edit
    @user = current_user
    UserMailer.deliver_registration_confirmation(@user)
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if verify_recaptcha(:model => @user, :message => "The scrambled words were incorrect") && @user.save
        
        # Send out the welcome e-mail
        UserMailer.deliver_registration_confirmation(@user)
        
        flash[:notice] = 'Welcome to Deesis!'
        format.html { redirect_to root_url }
      else
        flash[:notice] = 'Fix a few errors, and let\'s try this again'
        format.html { render :action => 'new' }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = current_user

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'Your profile has been updated'
        format.html { redirect_to edit_user_path(:current) }
      else
        flash[:notice] = 'We couldn\'t update your profile.  Fix the errors, and let\'s try again'
        format.html { redirect_to edit_user_path(:current) }
      end
    end
  end
end
