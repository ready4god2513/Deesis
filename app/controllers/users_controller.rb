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
  
  def activity
    @user = User.find_by_username(params[:username])
    @activities = @user.activity
     
    respond_to do |format|
      format.html
      format.xml { render :xml => @activities }
      format.json { render :json => @activities }
      format.rss  { render :rss => @activities }
      format.atom  { render :atom => @activities }
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
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if verify_recaptcha(:model => @user, :message => "The scrambled words were incorrect") && @user.save
        @activity = Activity.new(:user_id => @user.id, :activity => 'Signed up for an account', :link_to => profile_path(@user.username))
        @activity.save
        flash[:notice] = 'Your account has been created'
        format.html { redirect_to root_url }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
        format.json  { render :json => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = current_user

    respond_to do |format|
      if @user.update_attributes(params[:user])
        @activity = Activity.new(:user_id => @user.id, :activity => 'Updated Profile')
        @activity.save
        flash[:notice] = 'Your profile has been updated'
        format.html { redirect_to edit_user_path(:current) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
end
