class PrayersController < ProtectedController
  
  # GET /prayers
  # GET /prayers.xml
  def index
    @prayers = Prayer.search(params[:search], params[:page], params[:per])
    @prayer = Prayer.new
    
    respond_to do |format|
      format.html # index.html.erb
      format.js { }
      format.rss { render :rss => @prayers }
      format.atom { render :atom => @prayers }
    end
  end
  
  def answered
    @prayer = Prayer.find(params[:id])
    @prayer.answered = 1

    respond_to do |format|
      if @prayer.save
        
        # Send out an email letting users know the prayer was answered
        Reminder.send_prayer_answered(@prayer)
        
        # Remove reminders
        Reminder.remove_by_prayer(@prayer)
        
        flash[:notice] = "Answered prayers are so encouraging, aren't they?"
        format.html { redirect_to root_url }
      else
        format.html { redirect_to root_url }
      end
    end
  end

  # GET /prayers/1
  def show
    @prayer = Prayer.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
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
        
        # Add this prayer to the user's list of reminders
        @reminder = Reminder.new({ :prayer_id => @prayer.id, :user_id => current_user.id})
        @reminder.save
        
        flash[:notice] = 'Your prayer has been added'
        format.html { redirect_to(@prayer) }
        format.js { }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /prayers/1
  # PUT /prayers/1.xml
  def update
    @prayer = Prayer.find(params[:id])
    
    # Ensure that the prayer belongs to the current user
    if @prayer.user_id != current_user.id
      redirect_to root_url
    end

    respond_to do |format|
      if @prayer.update_attributes(params[:prayer])
        
        flash[:notice] = 'Prayer was successfully updated.'
        format.html { redirect_to root_url }
        format.js {  }
      else
        format.html { redirect_to root_url }
      end
    end
  end
  
end
