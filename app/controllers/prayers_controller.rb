class PrayersController < ApplicationController
  
  # Require that a current user is logged in
  before_filter :require_login
  
  # GET /prayers
  # GET /prayers.xml
  def index
    @prayers = Prayer.search(params[:search], params[:page], params[:per])
    @comments = Comment.all(:limit => 2)
    @prayer = Prayer.new
    
    respond_to do |format|
      format.html # index.html.erb
      format.js { }
      format.xml  { render :xml => @prayers }
      format.json { render :json => @prayers }
      format.rss { render :rss => @prayers }
      format.atom { render :atom => @prayers }
    end
  end

  # GET /prayers/1
  # GET /prayers/1.xml
  def show
    @prayer = Prayer.find(params[:id])
    @comments = @prayer.comment(:limit => 2)
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @prayer }
      format.json { render :json => @prayer }
    end
  end

  # GET /prayers/1/edit
  def edit
    @prayer = Prayer.find(params[:id])
    
    # Ensure that the prayer belongs to the current user
    if !current_user || @prayer.user_id != current_user.id
      redirect_to root_url
    end
  end

  # POST /prayers
  # POST /prayers.xml
  def create
    if !current_user
      redirect_to root_url
    end
    
    @prayer = Prayer.new(params[:prayer])
    @prayer.user_id = current_user.id

    respond_to do |format|
      if @prayer.save
        flash[:notice] = 'Your prayer has been added'
        format.html { redirect_to(@prayer) }
        format.js { }
        format.xml  { render :xml => @prayer, :status => :created, :location => @prayer }
        format.json { render :json => @prayer, :status => :created, :location => @prayer }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @prayer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /prayers/1
  # PUT /prayers/1.xml
  def update
    @prayer = Prayer.find(params[:id])

    respond_to do |format|
      if @prayer.update_attributes(params[:prayer])
        flash[:notice] = 'Prayer was successfully updated.'
        format.html { redirect_to root_url }
        format.xml  { head :ok }
      else
        format.html { redirect_to root_url }
        format.xml  { render :xml => @prayer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /prayers/1
  # DELETE /prayers/1.xml
  def destroy
    @prayer = Prayer.find(params[:id])
    @prayer.destroy
    
    @comments = Comment.find_by_prayer_id(params[:id])
    @comments.destory

    respond_to do |format|
      format.html { redirect_to root_url }
      format.xml  { head :ok }
    end
  end
end
