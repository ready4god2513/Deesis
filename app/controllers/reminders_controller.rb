class RemindersController < ApplicationController
  
  def create
    @reminder = Reminder.new(params[:reminder])
    
    respond_to do |format|
      if @reminder.save
        flash[:notice] = 'You will be reminded to pray for this prayer.'
        format.html { redirect_to(account_path) }
        format.js { }
      else
        flash[:error] = 'You have already added this prayer to your reminders'
        format.html { redirect_to(account_path) }
        format.xml  { render :xml => @prayer.errors, :status => :unprocessable_entity }
      end
    end
    
  end

  def destroy
    @reminder = Reminder.find(params[:id])
    @reminder.delete
    
    respond_to do |format|
      if @reminder.save
        flash[:notice] = 'This prayer has been removed from your reminders'
        format.html { redirect_to(account_path) }
        format.js { }
      else
        format.html { redirect_to(account_path) }
        format.xml  { render :xml => @prayer.errors, :status => :unprocessable_entity }
      end
    end
  end

end
