class SurveysController < ApplicationController
  load_and_authorize_resource

  before_action :set_survey, only: [:show, :edit, :update, :destroy]
  respond_to :html
  respond_to :xml, :json, :csv, :xls, :js, :except => [ :edit, :new, :update, :create ]

  def index
    @surveys = Survey.all
    respond_with(@surveys)
  end

  def show
    respond_with(@survey)
  end

  def new
    @survey = Survey.new
    respond_with(@survey)
  end

  def edit
  end

  def create
    @survey = Survey.new(survey_params)
    @survey.admin_id = @currently_signed_in.id
    track_activity @survey if @survey.save
    respond_with @survey, location: -> { after_save_path_for(@survey) }
  end

  def update
    @survey.update(survey_params)
    # respond_with @survey, location: -> { after_save_path_for(@survey) }
    respond_to do |format|
      if @survey.update_attributes(survey_params)
        flash[:success] = "Survey updated successfully!"
        format.html { redirect_to(@survey, :notice => 'Survey was successfully updated.') }
        format.json { respond_with_bip(@survey) }
      else
        flash[:error] = @survey.errors.full_messages.join(", ")
        format.html { render :action => "edit" }
        format.json { respond_with_bip(@survey) }
      end
    end
  end

  def destroy
    @survey.destroy
    respond_with(@survey)
  end

  def approve
    @survey = Survey.find( params[:id] )
    @survey.approved!
    if @survey.approved?
      track_activity @survey
      @survey.update_column :reviewer_id, current_admin.id
      flash[:success] = review_success_msg("approved")
    else
      flash[:error] = review_error_msg
    end
    refresh_supervisor_controls( @survey )
  end

  def reject
    @survey = Survey.find( params[:id] )
    @survey.rejected!
    if @survey.rejected?
      track_activity @survey
      @survey.update_column :reviewer_id, current_admin.id
      flash[:success] = review_success_msg("Rejected")
    else
      flash[:error] = review_error_msg
    end
    refresh_supervisor_controls( @survey )
  end

  def pend
    @survey = Survey.find( params[:id] )
    @survey.pending!
    if @survey.pending?
      track_activity @survey
      @survey.update_column :reviewer_id, current_admin.id
      flash[:success] = review_success_msg("Pending")
    else
      flash[:error] = review_error_msg
    end
    refresh_supervisor_controls( @survey )
  end

  private
  
  def set_survey
    @survey = Survey.find(params[:id])
  end

  def survey_params
    params.require(:survey).permit(
      :desa_id, 
      :end_time, 
      :fishery_id, 
      :start_time, 
      :admin_id, 
      :user_id, 
      :date_published, 
      :observer, 
      :approved,
      :catch_measurer_id,
      :catch_scribe_id,
      :landing_enumerator_id,
      :vessel_count,
      :review_state,
      :reviewed_at,
      :reviewer,
      :start_time_input,
      :end_time_input
      )
  end

  def after_save_path_for(resource)
    survey_path(resource)
  end

  def refresh_supervisor_controls( survey )
    respond_to do |format|
      format.html { redirect_to survey  }
      format.js {
        @survey = survey 
        render :refresh_supervisor_controls
      }
    end
  end

  def review_success_msg( state )
    "Survey successfully reviewed: #{state.upcase}"
  end

  def review_error_msg
    "We encountered an error reviewing this survey. Please try again."
  end

end


