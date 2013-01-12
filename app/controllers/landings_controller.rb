class LandingsController < InheritedResources::Base
  load_and_authorize_resource

  respond_to :html, :xml, :json, :except => [ :edit, :new, :update, :create ]

  def index
    @landings = Landing.all
    respond_to do |format|
    	format.html
    	format.json { render :json=>@landings }
    	format.xml { render :xml=>@landings }
    end
  end
end
