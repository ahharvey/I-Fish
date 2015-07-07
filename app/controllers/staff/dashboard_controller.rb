class Staff::DashboardController < ApplicationController
	#authorize_resource :class => false
  def index
    authorize! :index, 'staff/dashboard'
		
    @pending_vessels = PendingVessel.pending
    
	end
end