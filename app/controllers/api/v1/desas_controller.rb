module Api
  module V1
    class DesasController < ApplicationController
      respond_to :json
      
      def index
        @desas = Desa.all
      end
      
      def show
        @desa = Desa.find(params[:id])
      end
      
      def create
        respond_with Desa.create(desa_params)
      end
      
      def update
        respond_with Desa.update(params[:id], params[:desas])
      end
      
      def destroy
        respond_with Desa.destroy(params[:id])
      end

      private
  
      def desa_params
        params.require(:desa).permit( :name, :kabupaten, :code, :lat, :lng, :district_id )
      end
    end
  end
end