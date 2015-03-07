
class ActivitiesController < ApplicationController
  load_and_authorize_resource

  before_action :set_activity, only: [:show, :edit, :update, :destroy]
  respond_to :html
  respond_to :xml, :json, :csv, :xls, :js, :except => [ :edit, :new, :update, :create ]

  def index
    @activities = Activity.all
    respond_with(@activities)
  end

  def show
    respond_with(@activity)
  end

  def new
    @activity = Activity.new
    respond_with(@activity)
  end

  def edit
  end

  def create
    @activity = Activity.new(activity_params)
    @activity.save
    respond_with @activity, location: -> { after_save_path_for(@activity) }
  end

  def update
    @activity.update(activity_params)
    respond_with @activity, location: -> { after_save_path_for(@activity) }
  end

  def destroy
    @activity.destroy
    respond_with(@activity)
  end

  private
  
  def set_activity
    @activity = Activity.find(params[:id])
  end

  def activity_params
    params.require(:activity).permit(
      :action, 
      :ownable, 
      :trackable, 
      :trackable_type, 
      :trackable_id, 
      :ownable_id, 
      :ownable_type
      )
  end

  def after_save_path_for(resource)
    activity_path(resource)
  end

end

