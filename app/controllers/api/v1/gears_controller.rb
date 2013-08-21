module Api
  module V1
    class GearsController < ApplicationController
      respond_to :json
      
      def index
        @gears = Gear.all
      end
      
      def show
        @gear = Gear.find(params[:id])
      end
      
      def create
        respond_with Gear.create(params[:gear])
      end
      
      def update
        respond_with Gear.update(params[:id], params[:gears])
      end
      
      def destroy
        respond_with Gear.destroy(params[:id])
      end
    end
  end
end