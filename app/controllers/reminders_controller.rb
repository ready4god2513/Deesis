class RemindersController < ApplicationController
  
  def create
    @reminder = Reminder.new(params[:reminder])

    respond_to do |format|
      if @reminder.save
        flash[:notice] = 'This prayer has been added to your reminder list'
        format.html { redirect_to(root_path) }
      else
        flash[:notice] = 'This prayer is already part of your reminder list'
        format.html { redirect_to(root_path) }
      end
    end
  end

  def destroy
    @reminder = Reminder.find(params[:id])
    @reminder.destroy

    respond_to do |format|
      format.html { redirect_to(root_path) }
      format.xml  { head :ok }
    end
  end
end
