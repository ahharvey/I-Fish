module Api
  module V1
    class VesselsController < ApplicationController
      respond_to :json

      before_filter :restrict_access
      
      def index
        @vessels = Vessel.includes(:gear, :vessel_type).where(ap2hi_ref: params[:uvi]) if params[:uvi]
        @vessels = Vessel.all unless params[:uvi]
      end
      
#      def show
#        respond_with Vessel.find(params[:id])
#      end
#      
#      def create
#        respond_with User.create(user_params)
#      end
#      
#      def update
#        respond_with User.update(params[:id], params[:users])
#      end
#      
#      def destwhere(ap2hi_ref: params[:uvi])
#        respond_with User.destroy(params[:id])
#      end

#      private#

#      def user_params
#        params.require(:user).permit( :email, :password, :password_confirmation, :remember_me, :name, :avatar, :crop_x, :crop_y, :crop_w, :crop_h, :notes, :vessel_type_id, :length, :engine_id, :power, :desa_id, :confirmed_at)
#      end
    end
  end
end