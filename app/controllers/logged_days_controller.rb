class LoggedDaysController < ApplicationController
  load_and_authorize_resource

  before_action :set_logged_day, only: [:show, :edit, :update, :destroy]
  respond_to :html
  respond_to :xml, :json, :except => [ :edit, :new, :update, :create ]

  def index
    @logged_days = LoggedDay.all
    respond_with(@logged_days)
  end

  def show
    respond_with(@logged_day)
  end

  def new
    @logged_day = LoggedDay.new
    respond_with(@logged_day)
  end

  def edit
  end

  def create
    @logged_day = LoggedDay.new(logged_day_params)
    @logged_day.save
    respond_with @logged_day, location: -> { after_save_path_for(@logged_day) }
  end

  def update
    @logged_day.update(logged_day_params)
    #respond_with @logged_day, location: -> { after_save_path_for(@logged_day) }
    respond_to do |format|
      if @logged_day.update_attributes(logged_day_params)
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

  def destroy
    @logged_day.destroy
    respond_with(@logged_day)
  end

  private
  
  def set_logged_day
    @logged_day = LoggedDay.find(params[:id])
  end

  def logged_day_params
    params.require(:logged_day).permit(
      :condition, 
      :crew, 
      :end_time, 
      :fuel, 
      :gear_time, 
      :line, 
      :moon, 
      :net, 
      :quantity, 
      :sail, 
      :start_time, 
      :value, 
      :weight, 
      :fish_id, 
      :logbook_id, 
      :graticule_id, 
      :ice, 
      :aborted, 
      :notes, 
      :start_time_input, 
      :start_date_input
      )
  end

  def after_save_path_for(resource)
    logged_day_path(resource)
  end

end


