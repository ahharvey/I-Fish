class SupervisorController < InheritedResources::Base

	def dashboard
		@surveys = Survey.where(approved: false)
		@logbooks = Logbook.where(approved: false)
		@admins = Admin.wehere(approved: false)
	end

end