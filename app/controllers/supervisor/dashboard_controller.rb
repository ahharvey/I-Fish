class Supervisor::DashboardController < ApplicationController
	def index
		@surveys = Survey.where(approved: false)
		@logbooks = Logbook.where(approved: false)
		@admins = Admin.where(approved: false)
	end
end