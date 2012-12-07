class LandingsController < InheritedResources::Base

	def index
@landings = Landing.all
	end
end
