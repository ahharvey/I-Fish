class Supervisor::DashboardController < ApplicationController
	#authorize_resource :class => false
  def index
    authorize! :index, 'supervisor/dashboard'
		
    @surveys = Survey.scoped
    @unapproved_surveys = @surveys.where(approved: false)
    @historical_surveys = @surveys.
      where(approved: true).
      where('date_published > ?', Date.today.beginning_of_month-1.year).
      group_by { |t| t.date_published.beginning_of_month }
		
    @logbooks = Logbook.scoped
    @unapproved_logbooks = @logbooks.where(approved: false)
    @historical_logbooks = @logbooks.
      where(approved: true).
      where('date > ?', Date.today.beginning_of_month-1.year).
      group_by { |t| t.date.beginning_of_month }

		@admins = Admin.where(approved: false)

    @historical_records = []

    (@historical_surveys.keys + @historical_logbooks.keys).uniq.sort.each { |month|
      @historical_records << { month: month, survey: @historical_surveys[month].try(:length) || 0, logbook: @historical_logbooks[month].try(:length) || 0 }
    }
	end
end