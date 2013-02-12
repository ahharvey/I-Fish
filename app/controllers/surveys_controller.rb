class SurveysController < InheritedResources::Base
  load_and_authorize_resource

  respond_to :html, :xml, :json, :except => [ :edit, :new, :update, :create ]

  def create
    @survey = Survey.new(params[:survey])
    @survey.user_id=current_user.id
    create!
  end

  def set_approved
	  @survey = Survey.find( params[:id] )
	  @survey.update_column :approved, params[:approved]
	  if @survey.approved == true
	  	@survey.update_column :approver_id, current_admin.id
	  else
	  	@survey.update_column :approver_id, ""
	  end
	  render nothing: true
	end

end
