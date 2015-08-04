class Staff::DashboardController < ApplicationController
	#authorize_resource :class => false
  def index
    authorize! :index, 'staff/dashboard'
		
    @pending_vessels = PendingVessel.pending
   
		
    @unloadings = Unloading.where(vessel_id: current_admin.managed_vessels.map(&:id) )
    @unapproved_unloadings = @unloadings.where( review_state: 'pending' )
    @historical_unloadings = @unloadings.
      where( review_state: 'approved' ).
      where('time_in > ?', Date.today.beginning_of_month-1.year).
      group_by { |t| t.time_in.beginning_of_month }
		
    @bait_loadings = BaitLoading.where(vessel_id: current_admin.managed_vessels.map(&:id) )
    @unapproved_bait_loadings = @bait_loadings.where( review_state: 'pending' )
    @historical_bait_loadings = @bait_loadings.
      where( review_state: 'approved').
      where('date > ?', Date.today.beginning_of_month-1.year).
      group_by { |t| t.date.beginning_of_month }

		@admins = Admin.where(approved: false, office_id: current_admin.office_id)

    @historical_records = []

    (@historical_unloadings.keys + @historical_bait_loadings.keys).uniq.sort.each { |month|
      @historical_records << { month: month, survey: @historical_unloadings[month].try(:length) || 0, logbook: @historical_bait_loadings[month].try(:length) || 0 }
    }
	end
end