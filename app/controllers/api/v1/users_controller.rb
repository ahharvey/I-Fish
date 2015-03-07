module Api
  module V1
    class UsersController < ApplicationController
      respond_to :json
      
      def index
        respond_with User.all
      end
      
      def show
        respond_with User.find(params[:id])
      end
      
      def create
        respond_with User.create(user_params)
      end
      
      def update
        respond_with User.update(params[:id], params[:users])
      end
      
      def destroy
        respond_with User.destroy(params[:id])
      end

      private

      def user_params
        params.require(:user).permit( :email, :password, :password_confirmation, :remember_me, :name, :avatar, :crop_x, :crop_y, :crop_w, :crop_h, :notes, :vessel_type_id, :length, :engine_id, :power, :desa_id, :confirmed_at)
      end
    end
  end
end