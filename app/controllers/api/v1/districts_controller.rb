module Api
  module V1
    class DistrictsController < ApplicationController
      respond_to :json
      
      def index
        @districts = District.all
      end
      
      def show
        @district = District.find(params[:id])
      end
      
      def create
        respond_with District.create(params[:district])
      end
      
      def update
        respond_with District.update(params[:id], params[:districts])
      end
      
      def destroy
        respond_with District.destroy(params[:id])
      end
    end
  end
end