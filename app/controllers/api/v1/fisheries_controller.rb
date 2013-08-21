module Api
  module V1
    class FisheriesController < ApplicationController
      respond_to :json
      
      def index
        @fisheries = Fishery.all
      end
      
      def show
        @fishery = Fishery.find(params[:id])
      end
      
      def create
        respond_with Fishery.create(params[:fishery])
      end
      
      def update
        respond_with Fishery.update(params[:id], params[:fisheries])
      end
      
      def destroy
        respond_with Fishery.destroy(params[:id])
      end
    end
  end
end