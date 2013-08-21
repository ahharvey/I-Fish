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
    @survey = @currently_signed_in.surveys.find(params[:id])
    if @survey.update_attributes(params[:survey])
      track_activity @survey
      redirect_to @survey, notice: "Survey was updated."
    else
      render :edit
    end
  end

  def set_approved
    @survey = Survey.find( params[:id] )
    @survey.update_column :approved, params[:approved]
    if @survey.approved?
      track_activity @survey
      @survey.update_column :approver_id, current_admin.id
      flash[:success] = "Approved"
    else
      @survey.update_column :approver_id, nil
      flash[:error] = "Not Approved"
    end
    render nothing: true
  end

end
