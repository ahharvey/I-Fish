class LandingsController < InheritedResources::Base
  load_and_authorize_resource

  def index
    @landings = Landing.all
  end
end
