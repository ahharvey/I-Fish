class Supervisor::DashboardController < ApplicationController
	#authorize_resource :class => false
  def index
    authorize! :index, 'supervisor/dashboard'
		@surveys = Survey.where(approved: false)
		@logbooks = Logbook.where(approved: false)
		@admins = Admin.where(approved: false)
	end
end