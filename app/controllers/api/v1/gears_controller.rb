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
        respond_with Gear.create(gear_params)
      end
      
      def update
        respond_with Gear.update(params[:id], params[:gears])
      end
      
      def destroy
        respond_with Gear.destroy(params[:id])
      end

      private
  
      def gear_params
        params.require(:gear).permit( :alpha_code, :cat_eng, :cat_ind, :fao_code, :name, :num_code, :sub_cat_eng, :sub_cat_ind, :type_eng, :type_ind )
      end
    end
  end
end