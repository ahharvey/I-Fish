class SurveysController < InheritedResources::Base
  def create
    @survey = Survey.new(params[:survey])
    @survey.user_id=current_user.id
    create!
  end
end
