class SurveysController < InheritedResources::Base
  load_and_authorize_resource

  respond_to :html, :xml, :json, :except => [ :edit, :new, :update, :create ]

  def index
  end
  
  def create
    @survey = Survey.new(params[:survey])
    @survey.admin_id = @currently_signed_in.id
    if @survey.save 
      track_activity @survey
      redirect_to @survey
    else
      render :new
    end
  end

  def update
    @survey = Survey.find params[:id]

    respond_to do |format|
      if @survey.update_attributes(params[:survey])
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
