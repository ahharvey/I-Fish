module Api
  module V1
    class LogbooksController < ApplicationController
      respond_to :json
      
      def index
        @logbooks = Logbook.where(approved: true)
      end
      
      def show
        @logbook = Logbook.find(params[:id])
      end
      
      def create
        respond_with Logbook.create(logbook_params)
      end
      
      def update
        respond_with Logbook.update(params[:id], params[:logbooks])
      end
      
      def destroy
        respond_with Logbook.destroy(params[:id])
      end

      private

      def logbook_params
        params.require(:logbook).permit( :date, :user_id, :admin_id, :fishery_id, :review_state, :reviewed_at, :reviewer_id)
      end
    end
  end
end