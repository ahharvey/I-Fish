module Api
  module V1
    class SurveysController < ApplicationController
      respond_to :json
      
      def index
        @surveys = Survey.where(approved: true)
      end
      
      def show
        @survey = Survey.find(params[:id])
      end
      
      def create
        respond_with Survey.create(survey_params)
      end
      
      def update
        respond_with Survey.update(params[:id], params[:surveys])
      end
      
      def destroy
        respond_with Survey.destroy(params[:id])
      end

      private

      def survey_params
        params.require(:survey).permit( :desa_id, :end_time, :fishery_id, :start_time, :admin_id, :user_id, :date_published, :observer, :approved,:catch_measurer_id,:catch_scribe_id,:landing_enumerator_id,:vessel_count,:review_state,:reviewed_at,:reviewer,:start_time_input,:end_time_input)
      end
    end
  end
end