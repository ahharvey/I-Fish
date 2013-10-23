class Supervisor::DashboardController < ApplicationController
	load_and_authorize_resource
  def index
		@surveys = Survey.where(approved: false)
		@logbooks = Logbook.where(approved: false)
		@admins = Admin.where(approved: false)
	end
end