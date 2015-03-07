module Api
  module V1
    class ProvincesController < ApplicationController
      respond_to :json
      
      def index
        @provinces = Province.all
      end
      
      def show
        @province = Province.find(params[:id])
      end
      
      def create
        respond_with Province.create(province_params)
      end
      
      def update
        respond_with Province.update(params[:id], params[:provinces])
      end
      
      def destroy
        respond_with Province.destroy(params[:id])
      end

      private
  
      def province_params
        params.require(:province).permit( :name, :code, :year)
      end
    end
  end
end