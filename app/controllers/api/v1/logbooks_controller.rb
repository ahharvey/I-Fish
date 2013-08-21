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
        respond_with Logbook.create(params[:logbook])
      end
      
      def update
        respond_with Logbook.update(params[:id], params[:logbooks])
      end
      
      def destroy
        respond_with Logbook.destroy(params[:id])
      end
    end
  end
end