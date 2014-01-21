class LoggedDaysController < InheritedResources::Base
	load_and_authorize_resource

  respond_to :html, :xml, :json, :except => [ :edit, :new, :update, :create ]

  def update
    @logged_day = LoggedDay.find params[:id]

    respond_to do |format|
      if @logged_day.update_attributes(params[:logged_day])
        flash[:success] = "Logbook updated successfully!"
        format.html { redirect_to(@logged_day, :notice => 'Logbook was successfully updated.') }
        format.json { respond_with_bip(@logged_day) }
      else
        flash[:error] = @logged_day.errors.full_messages.join(", ")
        format.html { render :action => "edit" }
        format.json { respond_with_bip(@logged_day) }
      end
    end
  end
end
