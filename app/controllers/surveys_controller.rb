class SurveysController < InheritedResources::Base
  load_and_authorize_resource

  respond_to :html, :xml, :json, :except => [ :edit, :new, :update, :create ]

  def create
    @survey = Survey.new(params[:survey])
    @survey.user_id=current_user.id
    create!
  end

end
