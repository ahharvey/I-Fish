class Staff::DashboardController < ApplicationController
	#authorize_resource :class => false
  def index
    authorize! :index, 'staff/dashboard'

    @pending_vessels = PendingVessel.default.page(params[:vessel_page]).per(1)


    #@unloadings = current_admin.managed_unloadings.page(params[:page])
    @unloadings = current_admin.managed_unloadings.pending.default.page(params[:unloading_page]).per(10)
    @historical_unloadings = current_admin.managed_unloadings.approved.historical.group_by { |t| t.time_in.beginning_of_month }
    #@unloadings.
#      where( review_state: 'approved' ).
#      where('time_in > ?', Date.today.beginning_of_month-1.year).
#

    #@bait_loadings = current_admin.managed_bait_loadings.page(params[:page])
    @bait_loadings = current_admin.managed_bait_loadings.pending.default.page(params[:bait_page]).per(10)
    @historical_bait_loadings = current_admin.managed_bait_loadings.approved.historical.group_by { |t| t.date.beginning_of_month }
#      where( review_state: 'approved').
#      where('date > ?', Date.today.beginning_of_month-1.year).
#

		@admins = current_admin.team_members.pending  #Admin.where(approved: false, office_id: current_admin.office_id)

    @historical_records = []

    (@historical_unloadings.keys + @historical_bait_loadings.keys).uniq.sort.each { |month|
      @historical_records << { month: month, survey: @historical_unloadings[month].try(:length) || 0, logbook: @historical_bait_loadings[month].try(:length) || 0 }
    }
	end
end
