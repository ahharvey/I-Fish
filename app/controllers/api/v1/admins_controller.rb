module Api
  module V1
    class AdminsController < ApplicationController
      respond_to :json
      
      def index
        respond_with Admin.all
      end
      
      def show
        respond_with Admin.find(params[:id])
      end
      
      def create
        respond_with Admin.create(admin_params)
      end
      
      def update
        respond_with Admin.update(params[:id], params[:admins])
      end
      
      def destroy
        respond_with Admin.destroy(params[:id])
      end

      private
  
        def admin_params
          params.require(:admin).permit( :email, :password, :password_confirmation, :remember_me, :name, :approved, :office_id, :avatar, :crop_x, :crop_y, :crop_w, :crop_h
      )
        end
    end
  end
end